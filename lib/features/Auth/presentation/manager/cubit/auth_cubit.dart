import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_state.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? fullName;
  String? emailAddress;
  String? password;
  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  void emit(AuthState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String fullName,
    required String emailAddress,
    required String password,
  }) async {
    try {
      emit(SignUpLoadingState());
      this.fullName = fullName;
      this.emailAddress = emailAddress;
      this.password = password;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await createUserDocAtFirestore();
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      _handleFirebaseSignUpException(e);
    } catch (e) {
      emit(
        SignUpFailureState(
          'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      emit(SignInLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      _handleFirebaseSignInException(e);
      log(e.toString());
    } catch (e) {
      emit(SignInFailureState(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(SignOutLoadingState());
      await getIt<ProfileRepository>().clearProfile();
      await FirebaseAuth.instance.signOut();
      emit(SignOutSuccessState());
    } on FirebaseAuthException catch (e) {
      _handleFirebaseSignOutException(e);
      log(e.toString());
    } catch (e) {
      emit(SignOutFailureState(e.toString()));
    }
  }

  Future<void> createUserDocAtFirestore() async {
    final uid = _userId;
    if (uid == null) {
      log('Cannot create user doc: User ID is null');
      return;
    }
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = <String, dynamic>{
      'fullName': fullName,
      'emailAddress': emailAddress,
    };
    // Store the user in firestore at users collection through user id
    // instead of email address as id to ensure that each user has unique document
    await users
        .doc(uid)
        .set(user)
        .then((value) => log('User auth data added to Firestore'))
        .catchError(
          (error) => log('Failed to add user auth data to Firestore: $error'),
        );
  }

  void _handleFirebaseSignUpException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        emit(SignUpFailureState('The password provided is too weak.'));
        break;
      case 'email-already-in-use':
        emit(SignUpFailureState('The account already exists for that email.'));
        break;
      case 'invalid-email':
        emit(SignUpFailureState('The email address is not valid.'));
        break;
      case 'network-request-failed':
        emit(
          SignUpFailureState(
            'A network error has occurred. Please check your internet connection and try again.',
          ),
        );
        break;
      default:
        emit(
          SignUpFailureState(
            'An unexpected error occurred. Please try again later.',
          ),
        );
    }
  }

  void _handleFirebaseSignInException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        emit(SignInFailureState('No user found for that email.'));
        break;
      case 'wrong-password':
        emit(SignInFailureState('Wrong password provided for that user.'));
        break;
      case 'invalid-email':
        emit(SignInFailureState('The email address is not valid.'));
        break;
      case 'network-request-failed':
        emit(
          SignInFailureState(
            'A network error has occurred. Please check your internet connection and try again.',
          ),
        );
        break;
      default:
        emit(SignInFailureState(e.toString()));
    }
  }

  void _handleFirebaseSignOutException(FirebaseAuthException e) {
    switch (e.code) {
      case 'network-request-failed':
        emit(
          SignOutFailureState(
            'A network error has occurred. Please check your internet connection and try again.',
          ),
        );
        break;
      default:
        emit(SignOutFailureState(e.toString()));
    }
  }
}
