import 'dart:async';

import 'package:eventhub/controller/Create_event%20_controller.dart';
import 'package:eventhub/widgets/adresssearch_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final eventController = Get.put(EventController());
  LatLng? selectedLocation;
  String address = '';
  final mapController = MapController();
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _getCurrentLocation();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = 'Location services are disabled';
        });
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = 'Location permissions are denied';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _error = 'Location permissions are permanently denied';
        });
        return;
      }

      await _getCurrentLocation();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      mapController.move(selectedLocation!, 15);
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

  void _handleLocationSelected(Location location) {
    setState(() {
      LatLng newLocation = LatLng(location.latitude, location.longitude);

      mapController.move(newLocation, 15);

      selectedLocation = newLocation;
      address =
          '${location.latitude}, ${location.longitude}'; // Implement reverse geocoding here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          TextButton(
            onPressed: selectedLocation != null
                ? () {
                    eventController.setLocation(
                      address,
                      selectedLocation!.latitude,
                      selectedLocation!.longitude,
                    );
                    Get.back();
                  }
                : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: selectedLocation ?? const LatLng(0, 0),
              initialZoom: 15,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedLocation = point;
                  address =
                      '${point.latitude}, ${point.longitude}'; // Implement reverse geocoding here
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.eventhub.app',
                tileSize: 256,
              ),
              if (selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: AddressSearchBar(
              onLocationSelected: _handleLocationSelected,
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
