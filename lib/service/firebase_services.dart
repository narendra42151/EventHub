// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhub/model/eventModel.dart';
import 'package:get/get.dart';
//import 'package:sublime/model/eventModel.dart';

class FirebaseService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createEvent(EventModel event) async {
    try {
      await _firestore.collection('events').add(event.toJson());
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  Future<void> updateEvent(String eventId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('events').doc(eventId).update(data);
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  Future<List<EventModel>> getEvents() async {
    try {
      print('Fetching events...'); // Debug log
      final snapshot = await _firestore.collection('events').get();
      print('Found ${snapshot.docs.length} events'); // Debug log

      return snapshot.docs.map((doc) {
        final data = doc.data();
        print('Event data: $data'); // Debug log
        return EventModel.fromMap({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }

  Stream<QuerySnapshot> eventsStream() {
    return _firestore.collection('events').snapshots();
  }
}
