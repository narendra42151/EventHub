// import 'package:flutter/material.dart';
// import 'package:sublime/model/eventModel.dart';
// import 'package:sublime/widgets/event_detail_screen.dart';

// class EventCard extends StatelessWidget {
//   final EventModel event;

//   const EventCard({required this.event});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: InkWell(
//         onTap: () {
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             backgroundColor: Colors.transparent,
//             builder: (_) => EventDetailsSheet(event: event),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (event.imageUrls.isNotEmpty)
//               Image.network(
//                 event.imageUrls[0],
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     event.title,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(event.description),
//                   SizedBox(height: 8),
//                   Chip(
//                     label: Text(event.eventType),
//                     backgroundColor: _getEventTypeColor(event.eventType),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getEventTypeColor(String type) {
//     switch (type) {
//       case 'Promotion':
//         return Colors.blue[100]!;
//       case 'Discount':
//         return Colors.green[100]!;
//       default:
//         return Colors.orange[100]!;
//     }
//   }
// }
import 'package:eventhub/model/eventModel.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:eventhub/widgets/event_detail_screen.dart';
import 'package:flutter/material.dart';
// import 'package:sublime/model/eventModel.dart';
// import 'package:sublime/utils/Theme.dart';
// import 'package:sublime/widgets/event_detail_screen.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDeepPurple.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.secondaryWhite,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => EventDetailsSheet(event: event),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (event.imageUrls.isNotEmpty)
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.network(
                        event.imageUrls[0],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: _buildEventTypeChip(event.eventType),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 20,
                        color: AppColors.textDarkBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      style: AppTextStyles.body1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          _getEventIcon(event.eventType),
                          size: 16,
                          color: _getEventColor(event.eventType),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.eventType,
                          style: AppTextStyles.body1.copyWith(
                            color: _getEventColor(event.eventType),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getEventColor(type).withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getEventIcon(type),
            size: 16,
            color: AppColors.secondaryWhite,
          ),
          const SizedBox(width: 4),
          Text(
            type,
            style: AppTextStyles.body1.copyWith(
              color: AppColors.secondaryWhite,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getEventColor(String type) {
    switch (type) {
      case 'Promotion':
        return AppColors.primarySoftBlue;
      case 'Discount':
        return const Color(0xFF4CAF50); // Custom green that matches theme
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
