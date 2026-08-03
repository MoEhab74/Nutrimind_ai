import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';
import 'package:nutrimind_ai/features/scanner/data/repos/scan/scan_repo.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit({required this.scanRepo}) : super(ScanInitial());
  final ScanRepo scanRepo;
  FoodModel? _foodModel;
  XFile? _image;

  // Getters
  FoodModel? get foodModel => _foodModel;
  XFile? get image => _image;

  Future<void> scanImage({required XFile image}) async {
    _image = image;
    emit(ScanLoading());
    final result = await scanRepo.scanProduct(image: image);
    result.fold((failure) => emit(ScanError(errorMessage: failure)), (
      foodModel,
    ) {
      _foodModel = foodModel;
      emit(ScanSuccess(food: foodModel));
    });
  }
}
