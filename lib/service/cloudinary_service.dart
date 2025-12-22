import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
// lib/service/cloudinary_service.dart
import 'package:get/get.dart';

class CloudinaryService extends GetxService {
  final cloudinary = CloudinaryPublic('dhwuxvadl', 'eawmdcc9');

  Future<String> uploadImage(String filePath) async {
    try {
      // Validate file exists before upload
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Image file not found: $filePath');
      }

      // Check file size (Cloudinary has limits)
      final fileSize = await file.length();
      if (fileSize > 100 * 1024 * 1024) {
        // 100MB limit
        throw Exception(
            'Image file is too large: ${fileSize / (1024 * 1024)} MB');
      }

      print('Uploading image: $filePath (Size: ${fileSize / 1024} KB)');

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          filePath,
          folder: 'events',
        ),
      );

      if (response.secureUrl.isEmpty) {
        throw Exception('Upload failed: Empty response URL');
      }

      print('Image uploaded successfully: ${response.secureUrl}');
      return response.secureUrl;
    } catch (e) {
      print('Cloudinary upload error: $e');
      throw Exception('Failed to upload image: $e');
    }
  }
}
