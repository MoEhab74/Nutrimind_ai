import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';

abstract class ScanRepo {
  Future<Either<String, FoodModel>> scanProduct({required XFile image});
}
