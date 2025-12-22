import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhub/model/eventModel.dart';
import 'package:eventhub/service/LocationService.dart';
import 'package:eventhub/service/firebase_services.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:eventhub/widgets/adresssearch_bar.dart';
import 'package:eventhub/widgets/event_detail_screen.dart';
import 'package:eventhub/widgets/event_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LocationService _locationService = LocationService();
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  StreamSubscription<QuerySnapshot>? _eventsSubscription;
  MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<Marker> _markers = [];
  List<EventModel> _events = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();

    _setupEventsListener();
    // _loadEvents();
    _mapController = MapController();
    _checkLocationPermission();
    _getCurrentLocation();
  }

  void _setupEventsListener() {
    _eventsSubscription = _firebaseService.eventsStream().listen((snapshot) {
      final events = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return EventModel.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
      setState(() {
        _events = events;
        _updateMarkers();
      });
    });
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  // Build marker list from events + current location
  void _updateMarkers() {
    setState(() {
      _markers = [
        if (_currentLocation != null)
          Marker(
            point: _currentLocation!,
            width: 40,
            height: 40,
            // If using flutter_map >=5.0.0, replace 'child' with 'builder'
            child: const Icon(
              Icons.my_location,
              color: Colors.blue,
              size: 40,
            ),
          ),
        ..._events.map((event) => Marker(
              point: LatLng(event.latitude, event.longitude),
              width: 40,
              height: 40,
              // If using flutter_map >=5.0.0, replace 'child' with 'builder'
              child: GestureDetector(
                onTap: () => _showEventDetails(event),
                child: EventMarker(
                  event: event,
                  onTap: () => _showEventDetails(event),
                ),
              ),
            )),
      ];
    });
  }

  // Display bottom sheet with event details
  void _showEventDetails(EventModel event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EventDetailsSheet(event: event),
    );
  }

  // Check location permission
  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _error = 'Location services are disabled');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _error = 'Location permissions are denied');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() => _error = 'Location permissions are permanently denied');
        return;
      }
      await _getCurrentLocation();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    try {
      setState(() => _isLoading = true);
      final position = await _locationService.getCurrentLocation();

      if (position != null) {
        final updatedLocation = LatLng(position.latitude, position.longitude);
        setState(() {
          _currentLocation = updatedLocation;
          _updateMarkers();
          // _markers = [
          //   Marker(
          //     point: updatedLocation,
          //     width: 40.0,
          //     height: 40.0,
          //     // If using flutter_map >=5.0.0, replace 'child' with 'builder'
          //     child: Icon(
          //       Icons.location_pin,
          //       color: Colors.blue,
          //       size: 40,
          //     ),
          //   ),
          // ];
          _isLoading = false;
        });
        _mapController.move(updatedLocation, 15);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  // Handle manual address search
  // void _handleLocationSelected(Location location) {
  //   setState(() {
  //     final newLocation = LatLng(location.latitude, location.longitude);
  //     _mapController.move(newLocation, 15);
  //     _markers = [
  //       Marker(
  //         point: newLocation,
  //         width: 40.0,
  //         height: 40.0,
  //         // If using flutter_map >=5.0.0, replace 'child' with 'builder'
  //         child: Icon(Icons.location_pin, color: Colors.red, size: 40),
  //       ),
  //     ];
  //   });
  // }
  void _handleLocationSelected(Location location) {
    final newLocation = LatLng(location.latitude, location.longitude);
    _mapController.move(newLocation, 15);
    setState(() {
      _currentLocation = newLocation;
    });
    _updateMarkers(); // This will show both the current location and event markers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeepPurple,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Events Map',
          style: TextStyle(
            color: AppColors.secondaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ??
                  const LatLng(37.42796133580664, -122.085749655962),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.eventhub.app',
                tileSize: 256,
              ),
              MarkerLayer(markers: _markers),
              // Attribution widget
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '© OpenStreetMap contributors',
                    style: TextStyle(fontSize: 10, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),

          // Search Bar
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDeepPurple.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: AddressSearchBar(
                onLocationSelected: _handleLocationSelected,
              ),
            ),
          ),

          // Current Location Button
          Positioned(
            bottom: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDeepPurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: _getCurrentLocation,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(
                  Icons.my_location,
                  color: AppColors.secondaryWhite,
                ),
              ),
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            Container(
              color: Colors.black26, // Semi-transparent overlay
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const SpinKitSpinningLines(
                    color: AppColors
                        .primaryDeepPurple, // Primary color for the spinner
                    size: 50.0, // Size of the spinner
                    lineWidth: 3.0, // Thickness of the lines
                  ),
                ),
              ),
            ),

          // Error Display
          if (_error != null)
            Positioned(
              top: 160,
              left: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // void _showEventDetails(EventModel event) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (_) => Container(
  //       decoration: BoxDecoration(
  //         color: AppColors.secondaryWhite,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom,
  //       ),
  //       child: EventDetailsSheet(event: event),
  //     ),
  //   );
  // }
}
