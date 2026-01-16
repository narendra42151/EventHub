// import 'package:flutter/material.dart';
// import 'package:sublime/screens/create_event_screen.dart';
// import 'package:sublime/screens/event-screen.dart';
// import 'package:sublime/screens/mapScreen.dart';
// import 'package:sublime/utils/drawer.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     MapScreen(),
//     EventsScreen(),
//     CreateEventScreen(),
//     AppDrawer(),

//     // MapScreen(),
//     // EventsScreen(),
//     // CreateEventScreen(),
//     // ProfileScreen(),
//   ];

//   // ...existing code...

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 15,
//               spreadRadius: 0,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           child: BottomNavigationBar(
//             elevation: 0,
//             backgroundColor: Colors.white,
//             currentIndex: _currentIndex,
//             onTap: (index) => setState(() => _currentIndex = index),
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: Colors.blue[700],
//             unselectedItemColor: Colors.grey[400],
//             selectedLabelStyle: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//             unselectedLabelStyle: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 11,
//             ),
//             items: [
//               BottomNavigationBarItem(
//                 icon: AnimatedContainer(
//                   duration: Duration(milliseconds: 200),
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: _currentIndex == 0
//                         ? Colors.blue[50]
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(Icons.map),
//                 ),
//                 label: 'Map',
//               ),
//               BottomNavigationBarItem(
//                 icon: AnimatedContainer(
//                   duration: Duration(milliseconds: 200),
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: _currentIndex == 1
//                         ? Colors.blue[50]
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(Icons.event),
//                 ),
//                 label: 'Events',
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   height: 45,
//                   width: 45,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.blue[400]!, Colors.blue[700]!],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.blue.withOpacity(0.3),
//                         blurRadius: 8,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Icon(Icons.add, color: Colors.white),
//                 ),
//                 label: 'Create',
//               ),
//               BottomNavigationBarItem(
//                 icon: AnimatedContainer(
//                   duration: Duration(milliseconds: 200),
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: _currentIndex == 3
//                         ? Colors.blue[50]
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(Icons.person),
//                 ),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:eventhub/screens/create_event_screen.dart';
import 'package:eventhub/screens/event-screen.dart';
import 'package:eventhub/screens/mapScreen.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:eventhub/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MapScreen(),
    EventsScreen(),
    CreateEventScreen(),
    AppDrawer(),
  ];

  @override
  void initState() {
    super.initState();
    // Allow opening HomeScreen with a specific tab via query parameter:
    // e.g. Get.toNamed('/home?tab=1') to open Events tab.
    try {
      final tabParam = Get.parameters['tab'];
      if (tabParam != null) {
        final parsed = int.tryParse(tabParam);
        if (parsed != null && parsed >= 0 && parsed < _screens.length) {
          _currentIndex = parsed;
        }
      } else if (Get.arguments != null && Get.arguments is int) {
        final arg = Get.arguments as int;
        if (arg >= 0 && arg < _screens.length) _currentIndex = arg;
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDeepPurple.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.map_outlined, 'Map'),
                _buildNavItem(1, Icons.event_outlined, 'Events'),
                _buildCreateButton(),
                _buildNavItem(3, Icons.person_outline, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryDeepPurple.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  isSelected ? AppColors.primaryDeepPurple : AppColors.textGrey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.body1.copyWith(
                color: isSelected
                    ? AppColors.primaryDeepPurple
                    : AppColors.textGrey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDeepPurple.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.secondaryWhite,
          size: 32,
        ),
      ),
    );
  }
}
