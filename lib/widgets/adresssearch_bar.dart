import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressSearchBar extends StatefulWidget {
  final Function(Location) onLocationSelected;

  const AddressSearchBar({super.key, required this.onLocationSelected});

  @override
  _AddressSearchBarState createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends State<AddressSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        widget.onLocationSelected(locations.first);
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search location...',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _searchLocation(_searchController.text),
          ),
        ),
        onSubmitted: _searchLocation,
      ),
    );
  }
}
