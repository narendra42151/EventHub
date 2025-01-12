import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhub/model/eventModel.dart';
import 'package:eventhub/service/firebase_services.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  final RxList<EventModel> events = <EventModel>[].obs;
  final RxList<EventModel> filteredEvents = <EventModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedType = 'All'.obs;
  StreamSubscription<QuerySnapshot>? _eventsSubscription;

  @override
  void onInit() {
    super.onInit();
    // loadEvents();
    _setupEventsListener();
  }

  void _setupEventsListener() {
    _eventsSubscription = _firebaseService.eventsStream().listen((snapshot) {
      final eventsList = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return EventModel.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
      events.value = eventsList;
      filterEvents();
    });
  }

  void filterEvents() {
    filteredEvents.value = events.where((event) {
      final matchesSearch =
          event.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              event.description
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase());
      final matchesType =
          selectedType.value == 'All' || event.eventType == selectedType.value;
      return matchesSearch && matchesType;
    }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterEvents();
  }

  void updateSelectedType(String type) {
    selectedType.value = type;
    filterEvents();
  }

  @override
  void onClose() {
    _eventsSubscription?.cancel();
    super.onClose();
  }
}
