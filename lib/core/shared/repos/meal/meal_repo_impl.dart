import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/services/supabase_storage_service.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/core/shared/repos/meal/meal_repo.dart';

class MealRepoImpl implements MealRepo {
  // Injections I'll need here
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final SupabaseStorageService _supabaseStorageService;
  // Get uid
  String get uid => _firebaseAuth.currentUser!.uid;
  // Collection reference
  CollectionReference get mealsCollection =>
      _firebaseFirestore.collection('users').doc(uid).collection('meals');

  MealRepoImpl({
    required this._firebaseAuth,
    required this._firebaseFirestore,
    required this._supabaseStorageService,
  });
  @override
  Future<void> addMeal(MealModel meal, XFile mealImage) async {
    try {
      // Save Image to Supabase storage
      final imageUrl = await _supabaseStorageService.uploadImgeXfile(
        image: mealImage,
      );
      // Build meal model
      final mealMap = meal.toMap();
      // Add image url to meal map
      mealMap['mealImageUrl'] = imageUrl;
      // Save meal to Firestore
      await mealsCollection.add(mealMap);
      log('Meal Added to firestore successfully');
    } on Exception catch (e) {
      log('Error Adding Meal to Firestore: $e');
      rethrow;
    }
  }

  // get meals
  @override
  Future<List<MealModel>> getAllMeals() async {
    try {
      final querySnapshot = await mealsCollection.get();
      final meals = querySnapshot.docs
          .map((doc) => MealModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      log('Meals fetched successfully');
      return meals;
    } on Exception catch (e) {
      log('Error Fetching Meals: $e');
      rethrow;
    }
  }

  // getAllMeals ordered by mealDate ascending
  @override
  Future<List<MealModel>> getAllMealsOrderedByMealDate() async {
    try {
      final querySnapshot = await mealsCollection
          .orderBy('mealDate', descending: false)
          .get();
      final meals = querySnapshot.docs
          .map((doc) => MealModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      log('Meals fetched successfully');
      return meals;
    } on Exception catch (e) {
      log('Error Fetching Meals: $e');
      rethrow;
    }
  }
}
