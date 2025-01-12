import 'dart:io';

import 'package:eventhub/model/eventModel.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsSheet extends StatelessWidget {
  final EventModel event;
  final dateFormat = DateFormat('MMM dd, yyyy');

  EventDetailsSheet({required this.event});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDeepPurple.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildHandle(),
            Expanded(
              child: ListView(
                controller: controller,
                padding: EdgeInsets.all(24),
                children: [
                  _buildHeader(),
                  SizedBox(height: 24),
                  _buildDateAndLocation(),
                  SizedBox(height: 24),
                  _buildDescription(),
                  if (event.imageUrls.isNotEmpty) ...[
                    SizedBox(height: 24),
                    _buildImageGallery(),
                  ],
                  SizedBox(height: 32),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.textGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                event.title,
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.textDarkBlue,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getEventTypeColor(event.eventType).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getEventIcon(event.eventType),
                    size: 16,
                    color: _getEventTypeColor(event.eventType),
                  ),
                  SizedBox(width: 4),
                  Text(
                    event.eventType,
                    style: AppTextStyles.body1.copyWith(
                      color: _getEventTypeColor(event.eventType),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateAndLocation() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                color: AppColors.primarySoftBlue, size: 20),
            SizedBox(width: 12),
            Text(
              '${dateFormat.format(event.startDate)} - ${dateFormat.format(event.endDate)}',
              style: AppTextStyles.body1,
            ),
          ],
        ),
        if (event.address.isNotEmpty) ...[
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  color: AppColors.primarySoftBlue, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  event.address,
                  style: AppTextStyles.body1,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      event.description,
      style: AppTextStyles.body1,
    );
  }

  Widget _buildImageGallery() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: event.imageUrls.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDeepPurple.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              event.imageUrls[index],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 200,
                  height: 200,
                  color: AppColors.secondaryLightBlue,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primarySoftBlue),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _openDirections(event),
            icon: Icon(Icons.directions_outlined),
            label: Text('Directions'),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.secondaryWhite,
              backgroundColor: AppColors.primarySoftBlue,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _shareEvent(event),
            icon: Icon(Icons.share_outlined),
            label: Text('Share'),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.primarySoftBlue,
              backgroundColor: AppColors.secondaryLightBlue,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper methods and existing functionality remain the same
  Color _getEventTypeColor(String type) {
    switch (type) {
      case 'Promotion':
        return AppColors.primarySoftBlue;
      case 'Discount':
        return Color(0xFF4CAF50);
      default:
        return AppColors.accentOrange;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'Promotion':
        return Icons.campaign_outlined;
      case 'Discount':
        return Icons.local_offer_outlined;
      default:
        return Icons.event_available_outlined;
    }
  }

  Future<void> _openDirections(EventModel event) async {
    try {
      final lat = event.latitude.toStringAsFixed(6);
      final lng = event.longitude.toStringAsFixed(6);

      // Try platform-specific URL first
      final Uri androidUrl = Uri.parse(
        'geo:0,0?q=$lat,$lng',
      );

      final Uri iosUrl = Uri.parse(
        'maps://maps.apple.com/?daddr=$lat,$lng',
      );

      final Uri webUrl = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
      );

      if (Platform.isAndroid && await canLaunchUrl(androidUrl)) {
        await launchUrl(androidUrl);
      } else if (Platform.isIOS && await canLaunchUrl(iosUrl)) {
        await launchUrl(iosUrl);
      } else if (await canLaunchUrl(webUrl)) {
        await launchUrl(
          webUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch maps';
      }
    } catch (e) {
      print('Error launching maps: $e');
    }
  }

  Future<void> _shareEvent(EventModel event) async {
    final formattedDates =
        '${dateFormat.format(event.startDate)} - ${dateFormat.format(event.endDate)}';
    final lat = event.latitude.toStringAsFixed(6);
    final lng = event.longitude.toStringAsFixed(6);

    final mapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    final text = '''
🎉 ${event.title}
📝 ${event.description}
📍 Tap here for location: $mapsUrl
📅 $formattedDates
🏷️ ${event.eventType}
''';

    try {
      await Share.share(text);
    } catch (e) {
      print('Error sharing event: $e');
    }
  }
}
