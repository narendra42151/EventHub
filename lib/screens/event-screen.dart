// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sublime/controller/event_controller.dart';
// import 'package:sublime/widgets/event_card.dart';

// class EventsScreen extends GetView<EventsController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Events'),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: controller.updateSelectedType,
//             itemBuilder: (context) => [
//               PopupMenuItem(value: 'All', child: Text('All')),
//               PopupMenuItem(value: 'Promotion', child: Text('Promotion')),
//               PopupMenuItem(value: 'Discount', child: Text('Discount')),
//               PopupMenuItem(value: 'General', child: Text('General')),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: TextField(
//               onChanged: controller.updateSearchQuery,
//               decoration: InputDecoration(
//                 hintText: 'Search events...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(
//               () => controller.filteredEvents.isEmpty
//                   ? Center(child: Text('No events found'))
//                   : ListView.builder(
//                       itemCount: controller.filteredEvents.length,
//                       itemBuilder: (context, index) {
//                         final event = controller.filteredEvents[index];
//                         return EventCard(event: event);
//                       },
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:eventhub/controller/eventList_controller.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:eventhub/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsScreen extends GetView<EventsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryWhite,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondaryWhite,
              AppColors.secondaryLightBlue.withOpacity(0.3),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            _buildFilterChips(),
            _buildEventsList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primaryDeepPurple,
      title: Text(
        'Events',
        style: AppTextStyles.heading1.copyWith(
          color: AppColors.secondaryWhite,
          fontSize: 24,
        ),
      ),
      actions: [
        Theme(
          data: ThemeData(
            popupMenuTheme: PopupMenuThemeData(
              color: AppColors.secondaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list,
              color: AppColors.secondaryWhite,
            ),
            onSelected: controller.updateSelectedType,
            itemBuilder: (context) => [
              _buildPopupMenuItem('All'),
              _buildPopupMenuItem('Promotion'),
              _buildPopupMenuItem('Discount'),
              _buildPopupMenuItem('General'),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value) {
    return PopupMenuItem(
      value: value,
      child: Text(
        value,
        style: AppTextStyles.body1.copyWith(
          color: AppColors.textDarkBlue,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDeepPurple.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        style: AppTextStyles.body1.copyWith(
          color: AppColors.textDarkBlue,
        ),
        decoration: InputDecoration(
          hintText: 'Search events...',
          hintStyle: AppTextStyles.body1.copyWith(
            color: AppColors.textGrey,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primarySoftBlue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.secondaryWhite,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildFilterChip('All Events', 'All'),
            _buildFilterChip('Promotions', 'Promotion'),
            _buildFilterChip('Discounts', 'Discount'),
            _buildFilterChip('General', 'General'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = controller.selectedType.value == value;
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(
          label,
          style: AppTextStyles.body1.copyWith(
            color:
                isSelected ? AppColors.secondaryWhite : AppColors.textDarkBlue,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        backgroundColor: AppColors.secondaryWhite,
        selectedColor: AppColors.primarySoftBlue,
        onSelected: (selected) => controller.updateSelectedType(value),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? Colors.transparent
                : AppColors.primarySoftBlue.withOpacity(0.3),
          ),
        ),
        elevation: isSelected ? 2 : 0,
        shadowColor: AppColors.primarySoftBlue.withOpacity(0.3),
      ),
    );
  }

  Widget _buildEventsList() {
    return Expanded(
      child: Obx(
        () => controller.filteredEvents.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: controller.filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = controller.filteredEvents[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: EventCard(event: event),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: AppColors.textGrey.withOpacity(0.5),
          ),
          SizedBox(height: 16),
          Text(
            'No events found',
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.textGrey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
