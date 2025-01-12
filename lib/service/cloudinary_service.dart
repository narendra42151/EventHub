import 'package:cloudinary_public/cloudinary_public.dart';
// lib/service/cloudinary_service.dart
import 'package:get/get.dart';

class CloudinaryService extends GetxService {
  final cloudinary = CloudinaryPublic('dhwuxvadl', 'eawmdcc9');

  Future<String> uploadImage(String filePath) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, folder: 'events'),
      );
      return response.secureUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
