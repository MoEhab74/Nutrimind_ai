import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrimind_ai/core/shared/repos/user_repo/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  UserRepositoryImpl(this._firestore, this._auth);
  @override
  Future<Either<String, dynamic>> getUserData() async {
    try {
      final userId = _auth.currentUser!.uid;
      final user = await _firestore.collection('users').doc(userId).get();
      return Right(user.data());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
