// lib/controller/image_controller.dart
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../service/cloudinary_service.dart';

class ImageController extends GetxController {
  final selectedImages = <XFile>[].obs;
  final uploadedUrls = <String>[].obs;
  final isUploading = false.obs;

  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick images: $e');
    }
  }

  /// Copy image to app cache to prevent deletion issues
  Future<String?> _copyImageToAppCache(String imagePath) async {
    try {
      final File sourceFile = File(imagePath);

      // Check if source file exists
      if (!await sourceFile.exists()) {
        print('Source image file not found: $imagePath');
        return null;
      }

      final appCacheDir = await getApplicationCacheDirectory();
      final fileName =
          'event_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File cachedFile = File('${appCacheDir.path}/$fileName');

      // Copy file to app cache
      await sourceFile.copy(cachedFile.path);
      return cachedFile.path;
    } catch (e) {
      print('Error copying image to cache: $e');
      return null;
    }
  }

  Future<void> uploadImages() async {
    if (selectedImages.isEmpty) return;

    isUploading.value = true;
    try {
      for (var image in selectedImages) {
        // Copy image to app cache first to ensure file persistence
        final cachedImagePath = await _copyImageToAppCache(image.path);

        if (cachedImagePath == null) {
          Get.snackbar('Error', 'Failed to process image: ${image.name}');
          continue;
        }

        try {
          final url = await _cloudinaryService.uploadImage(cachedImagePath);
          uploadedUrls.add(url);

          // Clean up cached file after successful upload
          final cachedFile = File(cachedImagePath);
          if (await cachedFile.exists()) {
            await cachedFile.delete();
          }
        } catch (e) {
          print('Error uploading image ${image.name}: $e');
          Get.snackbar('Error', 'Failed to upload ${image.name}: $e');
          rethrow;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload images: $e');
      rethrow;
    } finally {
      isUploading.value = false;
    }
  }

  void clearSelectedImages() {
    selectedImages.clear();
  }

  void clearUploadedUrls() {
    uploadedUrls.clear();
  }
}
