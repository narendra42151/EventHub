// // lib/screens/create_event_screen.dart
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sublime/controller/Create_event%20_controller.dart';
// import 'package:sublime/controller/Image_controller.dart';
// import 'package:sublime/model/eventModel.dart';
// import 'package:sublime/screens/Locatio_picker_screen.dart';
// import 'package:sublime/service/firebase_services.dart';

// class CreateEventScreen extends GetView<EventController> {
//   final eventController = Get.put(EventController());
//   final imageController = Get.put(ImageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Event'),
//       ),
//       body: Obx(() => Stack(
//             children: [
//               Form(
//                 key: controller.formKey,
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TextFormField(
//                         decoration: InputDecoration(labelText: 'Event Title'),
//                         onChanged: (value) => controller.title.value = value,
//                         validator: (value) =>
//                             value?.isEmpty ?? true ? 'Title is required' : null,
//                       ),
//                       SizedBox(height: 16),

//                       TextFormField(
//                         decoration: InputDecoration(labelText: 'Description'),
//                         maxLines: 3,
//                         onChanged: (value) =>
//                             controller.description.value = value,
//                         validator: (value) => value?.isEmpty ?? true
//                             ? 'Description is required'
//                             : null,
//                       ),
//                       SizedBox(height: 16),

//                       DropdownButtonFormField<String>(
//                         decoration: InputDecoration(labelText: 'Event Type'),
//                         items: ['Promotion', 'Discount', 'General']
//                             .map((type) => DropdownMenuItem(
//                                   value: type,
//                                   child: Text(type),
//                                 ))
//                             .toList(),
//                         onChanged: (value) =>
//                             controller.eventType.value = value!,
//                         validator: (value) =>
//                             value == null ? 'Event type is required' : null,
//                       ),
//                       SizedBox(height: 16),

//                       // Date Pickers
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextButton.icon(
//                               icon: Icon(Icons.calendar_today),
//                               label: Text(
//                                   controller.startDate.value?.toString() ??
//                                       'Start Date'),
//                               onPressed: () async {
//                                 final date = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime.now(),
//                                   lastDate:
//                                       DateTime.now().add(Duration(days: 365)),
//                                 );
//                                 if (date != null)
//                                   controller.startDate.value = date;
//                               },
//                             ),
//                           ),
//                           Expanded(
//                             child: TextButton.icon(
//                               icon: Icon(Icons.calendar_today),
//                               label: Text(
//                                   controller.endDate.value?.toString() ??
//                                       'End Date'),
//                               onPressed: () async {
//                                 final date = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime.now(),
//                                   lastDate:
//                                       DateTime.now().add(Duration(days: 365)),
//                                 );
//                                 if (date != null)
//                                   controller.endDate.value = date;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),

//                       // Location Picker
//                       // ListTile(
//                       //   title: Text(controller.address.value.isEmpty
//                       //       ? 'Select Location'
//                       //       : controller.address.value),
//                       //   leading: Icon(Icons.location_on),
//                       //   onTap: () {
//                       //     // Navigate to location picker
//                       //   },
//                       // ),
//                       SizedBox(height: 16),
//                       ListTile(
//                         title: Text(controller.address.value.isEmpty
//                             ? 'Select Location'
//                             : controller.address.value),
//                         leading: Icon(Icons.location_on),
//                         onTap: () {
//                           Get.to(() => LocationPickerScreen());
//                         },
//                       ),

//                       // Image Picker
//                       ElevatedButton.icon(
//                         icon: Icon(Icons.image),
//                         label: Text('Add Images'),
//                         onPressed: imageController.pickImages,
//                       ),

//                       // Selected Images Preview
//                       if (imageController.selectedImages.isNotEmpty)
//                         SizedBox(
//                           height: 100,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: imageController.selectedImages.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Image.file(
//                                   File(imageController
//                                       .selectedImages[index].path),
//                                   height: 80,
//                                   width: 80,
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),

//                       SizedBox(height: 24),

//                       ElevatedButton(
//                         onPressed: () async {
//                           if (controller.formKey.currentState!.validate()) {
//                             try {
//                               // Upload images first
//                               await imageController.uploadImages();
//                               final userId =
//                                   FirebaseAuth.instance.currentUser?.uid;
//                               // Create event with uploaded image URLs
//                               final event = EventModel(
//                                 title: controller.title.value,
//                                 description: controller.description.value,
//                                 eventType: controller.eventType.value,
//                                 startDate: controller.startDate.value!,
//                                 endDate: controller.endDate.value!,
//                                 address: controller.address.value,
//                                 latitude: controller.latitude.value,
//                                 longitude: controller.longitude.value,
//                                 imageUrls: imageController.uploadedUrls,
//                                 creatorId: userId ??
//                                     'unknown-user-id', // Get from auth service
//                               );

//                               // Save to Firebase
//                               await Get.find<FirebaseService>()
//                                   .createEvent(event);

//                               Get.snackbar(
//                                   'Success', 'Event created successfully');
//                               Get.back();
//                             } catch (e) {
//                               Get.snackbar(
//                                   'Error', 'Failed to create event: $e');
//                             }
//                           }
//                         },
//                         child: Obx(() => controller.isLoading.value
//                             ? CircularProgressIndicator()
//                             : Text('Create Event')),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               if (controller.isLoading.value)
//                 Container(
//                   color: Colors.black54,
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//             ],
//           )),
//     );
//   }
// }

import 'dart:io';

import 'package:eventhub/controller/Create_event%20_controller.dart';
import 'package:eventhub/controller/Image_controller.dart';
import 'package:eventhub/model/eventModel.dart';
import 'package:eventhub/screens/Locatio_picker_screen.dart';
import 'package:eventhub/service/firebase_services.dart';
import 'package:eventhub/utils/App_theme.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEventScreen extends GetView<EventController> {
  final eventController = Get.put(EventController());
  final imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create Event',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: Obx(() => Stack(
              children: [
                Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(12, 100, 12, 12),
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // StyledTextField(
                          //   controller: TextEditingController(
                          //       text: controller.title.value),
                          //   hint: 'Event Title',
                          //   icon: Icons.event,
                          //   onChanged: (value) =>
                          //       controller.title.value = value,
                          // ),
                          Container(
                            decoration: BoxDecoration(
                              color: EventsAppTheme.cardColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: EventsAppTheme.accentColor
                                      .withOpacity(0.2)),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Event tittle',
                                hintStyle: TextStyle(color: Colors.white60),
                                prefixIcon: Icon(Icons.event,
                                    color: EventsAppTheme.accentColor),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                              ),
                              maxLines: 1,
                              onChanged: (value) =>
                                  controller.title.value = value,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: EventsAppTheme.cardColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: EventsAppTheme.accentColor
                                      .withOpacity(0.2)),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(color: Colors.white60),
                                prefixIcon: Icon(Icons.description,
                                    color: EventsAppTheme.accentColor),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                              ),
                              maxLines: 8,
                              onChanged: (value) =>
                                  controller.description.value = value,
                            ),
                          ),

                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: EventsAppTheme.cardColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: EventsAppTheme.accentColor
                                      .withOpacity(0.2)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: EventsAppTheme.cardColor,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.category,
                                    color: EventsAppTheme.accentColor),
                              ),
                              items: ['Promotion', 'Discount', 'General']
                                  .map((type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ))
                                  .toList(),
                              onChanged: (value) =>
                                  controller.eventType.value = value!,
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 365)),
                                    );
                                    if (date != null)
                                      controller.startDate.value = date;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: EventsAppTheme.cardColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: EventsAppTheme.accentColor
                                              .withOpacity(0.2)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: EventsAppTheme.accentColor),
                                        SizedBox(width: 8),
                                        Text(
                                          controller.startDate.value
                                                  ?.toString()
                                                  .split(' ')[0] ??
                                              'Start Date',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 365)),
                                    );
                                    if (date != null)
                                      controller.endDate.value = date;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: EventsAppTheme.cardColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: EventsAppTheme.accentColor
                                              .withOpacity(0.2)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: EventsAppTheme.accentColor),
                                        SizedBox(width: 5),
                                        Text(
                                          controller.endDate.value
                                                  ?.toString()
                                                  .split(' ')[0] ??
                                              'End Date',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => Get.to(() => LocationPickerScreen()),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    EventsAppTheme.cardColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: EventsAppTheme.accentColor
                                        .withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: EventsAppTheme.accentColor),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      controller.address.value.isEmpty
                                          ? 'Select Location'
                                          : controller.address.value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          GradientButton(
                            text: 'Add Images',
                            onPressed: imageController.pickImages,
                          ),
                          if (imageController.selectedImages.isNotEmpty)
                            Container(
                              height: 100,
                              margin: EdgeInsets.symmetric(vertical: 16),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    imageController.selectedImages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: EventsAppTheme.accentColor
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(imageController
                                            .selectedImages[index].path),
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: 24),
                          GradientButton(
                            text: 'Create Event',
                            isLoading: controller.isLoading.value,
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                try {
                                  await imageController.uploadImages();
                                  final userId =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  final event = EventModel(
                                    title: controller.title.value,
                                    description: controller.description.value,
                                    eventType: controller.eventType.value,
                                    startDate: controller.startDate.value!,
                                    endDate: controller.endDate.value!,
                                    address: controller.address.value,
                                    latitude: controller.latitude.value,
                                    longitude: controller.longitude.value,
                                    imageUrls: imageController.uploadedUrls,
                                    creatorId: userId ?? 'unknown-user-id',
                                  );

                                  await Get.find<FirebaseService>()
                                      .createEvent(event);
                                  Get.snackbar(
                                      'Success', 'Event created successfully');

                                  controller.title.value = '';
                                  controller.description.value = '';
                                  controller.eventType.value = '';
                                  controller.startDate.value = null;
                                  controller.endDate.value = null;
                                  controller.address.value = '';
                                  controller.latitude.value = 0.0;
                                  controller.longitude.value = 0.0;
                                  imageController.selectedImages.clear();
                                  imageController.uploadedUrls.clear();
                                  controller.formKey.currentState!.reset();

                                  Get.to("'/home");
                                } catch (e) {
                                  // Get.snackbar(
                                  //     'Error', 'Failed to create event: $e');
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

// Add a custom StyledTextField that includes the onChanged callback
class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final Function(String)? onChanged;

  const StyledTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EventsAppTheme.cardColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: EventsAppTheme.accentColor.withOpacity(0.2)),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        obscureText: isPassword,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white60),
          prefixIcon: Icon(icon, color: EventsAppTheme.accentColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
