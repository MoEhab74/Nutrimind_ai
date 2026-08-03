import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/shared/repos/meal/meal_repo.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit({required this._mealRepo}) : super(MealInitial());
  final MealRepo _mealRepo;

  Future<void> addMeal(MealModel meal, XFile mealImageXfile) async {
    emit(MealLoading());
    try {
      await _mealRepo.addMeal(meal, mealImageXfile);
      emit(MealAddedSuccessfully(mealModel: meal));
    } catch (e) {
      emit(MealFailure(errorMessage: e.toString()));
    }
  }

}
