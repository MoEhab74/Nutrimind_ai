import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final supabaseStorage = Supabase.instance.client.storage;

  Future<String> uploadImgeXfile({required XFile image}) async {
    try {
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      // Because image is a XFile we need to convert it to bytes
      // to upload it to supabase storage because we can't upload XFile directly to supabase storage
      final bytes = await image.readAsBytes();

      await supabaseStorage.from("meal-images").uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );

      final url = supabaseStorage.from("meal-images").getPublicUrl(fileName);
      log('Supabase Image uploaded successfully: $url');
      return url;
    } catch (e) {
      log('Supabase Upload Error: $e');
      rethrow;
    }
  }
}
