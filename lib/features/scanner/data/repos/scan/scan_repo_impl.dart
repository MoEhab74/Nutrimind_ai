import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/api/api_consumer.dart';
import 'package:nutrimind_ai/core/api/api_endpoints.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';
import 'package:nutrimind_ai/features/scanner/data/repos/scan/scan_repo.dart';

class ScanRepoImpl implements ScanRepo {
  final ImagePicker imagePicker;
  final ApiConsumer apiConsumer;

  ScanRepoImpl({required this.imagePicker, required this.apiConsumer});

  @override
  Future<Either<String, FoodModel>> scanProduct({required XFile image}) async {
    try {
      // Image picker using ur camera or gallery
      // I'll handle this in the view

      // Convert image to bytes
      final imageBytes = await image.readAsBytes();

      // Build the prompt and tell the Gemini API to analyze the image and return json
      const prompt =
          """Analyze this image of a food product and provide detailed nutritional information in JSON format.
      Return:
      {
        "name": "Product Name",
        "healthScore": 50,
        "calories": 200,
        "protein": 10,
        "carbs": 20,
        "fat": 10,
        "sugar": 10,
        "fiber": 10,
        "sodium": 10,
      }
      If the image is not food or the food cannot be identified confidently, return:
      {
        "error": "Food not detected"
      }
      """;

      // Get the json from the Gemini API
      final response = await apiConsumer.post(
        "${ApiEndpoints.baseUrl}${ApiKeys.apiKey}",
        data: {
          "systemInstruction": {
            "parts": [
              {"text": prompt},
            ],
          },
          "contents": [
            {
              "parts": [
                {"text": "Analyze this food image."},
                {
                  "inlineData": {
                    "mimeType": "image/jpeg",
                    "data": base64Encode(imageBytes),
                  },
                },
              ],
            },
          ],
          "generationConfig": {
            "temperature": 0.2,
            "responseMimeType": "application/json",
          },
        },
      );

      // Convert the json to FoodModel
      final responseData = response is Map ? response : response.data;
      final text = responseData['candidates'][0]['content']['parts'][0]['text'];

      String cleanText = (text as String).trim();
      if (cleanText.startsWith('```')) {
        cleanText = cleanText.replaceAll(RegExp(r'^```(json)?|```$'), '').trim();
      }

      final jsonMap = jsonDecode(cleanText);
      if (jsonMap['error'] != null) {
        return Left(jsonMap['error']);
      }
      final foodModel = FoodModel.fromJson(jsonMap);
      // Return the FoodModel
      return Right(foodModel);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
