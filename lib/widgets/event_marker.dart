// import 'package:flutter/material.dart';
// import 'package:sublime/model/eventModel.dart';

// class EventMarker extends StatelessWidget {
//   final EventModel event;
//   final VoidCallback onTap;

//   const EventMarker({required this.event, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: _getEventColor(event.eventType),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 5,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           _getEventIcon(event.eventType),
//           color: Colors.white,
//           size: 24,
//         ),
//       ),
//     );
//   }

//   Color _getEventColor(String type) {
//     switch (type) {
//       case 'Promotion':
//         return Colors.blue;
//       case 'Discount':
//         return Colors.green;
//       default:
//         return Colors.orange;
//     }
//   }

//   IconData _getEventIcon(String type) {
//     switch (type) {
//       case 'Promotion':
//         return Icons.campaign;
//       case 'Discount':
//         return Icons.local_offer;
//       default:
//         return Icons.event;
//     }
//   }
// }
import 'package:eventhub/model/eventModel.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:flutter/material.dart';
// import 'package:sublime/model/eventModel.dart';
// import 'package:sublime/utils/Theme.dart';

class EventMarker extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const EventMarker({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _getEventColor(event.eventType),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _getEventColor(event.eventType).withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.secondaryWhite,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: AppColors.secondaryWhite,
            width: 2,
          ),
        ),
        child: Icon(
          _getEventIcon(event.eventType),
          color: AppColors.secondaryWhite,
          size: 20,
        ),
      ),
    );
  }

  Color _getEventColor(String type) {
    switch (type) {
      case 'Promotion':
        return AppColors.primarySoftBlue;
      case 'Discount':
        return Color(0xFF4CAF50); // Custom green that matches theme
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
}
