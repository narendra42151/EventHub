// lib/controller/event_controller.dart
import 'dart:async';

import 'package:eventhub/controller/Image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Form fields
  final title = ''.obs;
  final description = ''.obs;
  final eventType = ''.obs;
  final startDate = Rx<DateTime?>(null);
  final endDate = Rx<DateTime?>(null);
  final address = ''.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isLoading = false.obs;

  // Validation methods
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    if (value.length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length < 10) {
      return 'Description is too short';
    }
    return null;
  }

  bool validateDates() {
    if (startDate.value == null || endDate.value == null) {
      Get.snackbar('Error', 'Please select both start and end dates');
      return false;
    }
    if (endDate.value!.isBefore(startDate.value!)) {
      Get.snackbar('Error', 'End date must be after start date');
      return false;
    }
    return true;
  }

  void setLocation(String addr, double lat, double lng) {
    address.value = addr;
    latitude.value = lat;
    longitude.value = lng;
  }

  Future<void> createEvent() async {
    if (!formKey.currentState!.validate() || !validateDates()) return;

    try {
      isLoading.value = true;

      // Upload images first through ImageController
      final imageController = Get.find<ImageController>();
      await imageController.uploadImages();

      // Create event in Firebase
      // Add your Firebase creation logic here

      Get.snackbar('Success', 'Event created successfully');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create event: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
