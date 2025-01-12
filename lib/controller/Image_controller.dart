// lib/controller/image_controller.dart
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> uploadImages() async {
    if (selectedImages.isEmpty) return;

    isUploading.value = true;
    try {
      for (var image in selectedImages) {
        final url = await _cloudinaryService.uploadImage(image.path);
        uploadedUrls.add(url);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload images: $e');
      throw e; // Re-throw to handle in event creation
    } finally {
      isUploading.value = false;
    }
  }
}
