// lib/models/event_model.dart
class EventModel {
  String? id;
  String title;
  String description;
  String eventType;
  DateTime startDate;
  DateTime endDate;
  String address;
  double latitude;
  double longitude;
  List<String> imageUrls;
  String creatorId;
  DateTime createdAt;

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
    required this.creatorId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      eventType: map['eventType'] ?? '',
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      address: map['address'] ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      creatorId: map['creatorId'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'eventType': eventType,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'imageUrls': imageUrls,
        'creatorId': creatorId,
        'createdAt': createdAt.toIso8601String(),
      };
}
