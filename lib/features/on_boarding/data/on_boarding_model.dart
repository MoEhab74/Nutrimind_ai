import 'package:nutrimind_ai/gen/assets.gen.dart';

class BoardingModel {
  const BoardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

  List<BoardingModel> kBoardingPages = [
  BoardingModel(
    image: Assets.images.onBoarding1.path,
    title: 'Track Your Daily Progress',
    subtitle:
        'Monitor calories, macros, hydration, and healthy habits with beautiful progress charts.',
  ),
  BoardingModel(
    image: Assets.images.onBoarding2.path,
    title: 'Eat Smarter with AI',
    subtitle:
        'Scan your meals and let AI instantly estimate calories, protein, carbs, fat, and provide nutrition insights.',
  ),
  BoardingModel(
    image: Assets.images.onBoarding3.path,
    title: 'Achieve Your Health Goals',
    subtitle:
        'Receive personalized recommendations based on your eating habits and health profile.',
  ),
];