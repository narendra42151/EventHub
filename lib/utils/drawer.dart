// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class AppDrawer extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;

// //     return Scaffold(
// //         body: Center(
// //       child: ListView(
// //         padding: EdgeInsets.zero,
// //         children: <Widget>[
// //           StreamBuilder<DocumentSnapshot>(
// //             stream: FirebaseFirestore.instance
// //                 .collection('users')
// //                 .doc(user?.uid)
// //                 .snapshots(),
// //             builder: (context, snapshot) {
// //               String userName = snapshot.data?.get('name') ?? 'User';
// //               return UserAccountsDrawerHeader(
// //                 accountName: Text(userName),
// //                 accountEmail: Text(user?.email ?? ''),
// //                 currentAccountPicture: CircleAvatar(
// //                   backgroundColor: Colors.white,
// //                   child: Text(
// //                     userName[0].toUpperCase(),
// //                     style: TextStyle(fontSize: 32, color: Colors.blue),
// //                   ),
// //                 ),
// //                 decoration: BoxDecoration(
// //                   color: Colors.blue,
// //                 ),
// //               );
// //             },
// //           ),
// //           // ListTile(
// //           //   leading: Icon(Icons.person),
// //           //   title: Text('Profile'),
// //           //   onTap: () {},
// //           // ),
// //           ListTile(
// //             leading: Icon(Icons.settings),
// //             title: Text('Settings'),
// //             onTap: () {},
// //           ),
// //           Divider(),
// //           ListTile(
// //             leading: Icon(Icons.notifications),
// //             title: Text('Notifications'),
// //             onTap: () {},
// //           ),
// //           ListTile(
// //             leading: Icon(Icons.help),
// //             title: Text('Help & Support'),
// //             onTap: () {},
// //           ),
// //           Divider(),
// //           ListTile(
// //             leading: Icon(Icons.logout, color: Colors.red),
// //             title: Text('Logout', style: TextStyle(color: Colors.red)),
// //             onTap: () async {
// //               await FirebaseAuth.instance.signOut();
// //               Get.offAllNamed('/login');
// //             },
// //           ),
// //         ],
// //       ),
// //     ));
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sublime/utils/Theme.dart';

// // class DrawerScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;

// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [
// //               Colors.blue.shade900,
// //               Colors.purple.shade900,
// //             ],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Column(
// //             children: [
// //               // Profile Section
// //               StreamBuilder<DocumentSnapshot>(
// //                 stream: FirebaseFirestore.instance
// //                     .collection('users')
// //                     .doc(user?.uid)
// //                     .snapshots(),
// //                 builder: (context, snapshot) {
// //                   String userName = snapshot.data?.get('name') ?? 'User';
// //                   String email = user?.email ?? '';

// //                   return Padding(
// //                     padding: const EdgeInsets.all(20),
// //                     child: Row(
// //                       children: [
// //                         Container(
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             border: Border.all(color: Colors.white, width: 2),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.white.withOpacity(0.2),
// //                                 blurRadius: 12,
// //                               ),
// //                             ],
// //                           ),
// //                           child: CircleAvatar(
// //                             radius: 40,
// //                             backgroundColor: Colors.white24,
// //                             child: Text(
// //                               userName[0].toUpperCase(),
// //                               style: TextStyle(
// //                                 fontSize: 32,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(width: 16),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 userName,
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 24,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 email,
// //                                 style: TextStyle(
// //                                   color: Colors.white70,
// //                                   fontSize: 16,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),

// //               // Navigation Items
// //               Expanded(
// //                 child: ClipRRect(
// //                   borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
// //                   child: BackdropFilter(
// //                     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.1),
// //                       ),
// //                       child: ListView(
// //                         padding: EdgeInsets.symmetric(vertical: 20),
// //                         children: [
// //                           _buildMenuItem(
// //                             icon: Icons.home_rounded,
// //                             title: 'Home',
// //                             onTap: () => Get.toNamed('/home'),
// //                           ),
// //                           _buildMenuItem(
// //                             icon: Icons.map_rounded,
// //                             title: 'Map',
// //                             onTap: () => Get.toNamed('/map'),
// //                           ),
// //                           _buildMenuItem(
// //                             icon: Icons.event_rounded,
// //                             title: 'Events',
// //                             onTap: () => Get.toNamed('/events'),
// //                           ),
// //                           _buildMenuItem(
// //                             icon: Icons.person_rounded,
// //                             title: 'Profile',
// //                             onTap: () => Get.toNamed('/profile'),
// //                           ),
// //                           Divider(color: Colors.white24, height: 40),
// //                           _buildMenuItem(
// //                             icon: Icons.settings_rounded,
// //                             title: 'Settings',
// //                             onTap: () => Get.toNamed('/settings'),
// //                           ),
// //                           _buildMenuItem(
// //                             icon: Icons.logout_rounded,
// //                             title: 'Logout',
// //                             onTap: () async {
// //                               await FirebaseAuth.instance.signOut();
// //                               Get.offAllNamed('/login');
// //                             },
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildMenuItem({
// //     required IconData icon,
// //     required String title,
// //     required VoidCallback onTap,
// //   }) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(15),
// //         child: Container(
// //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(15),
// //             color: Colors.white.withOpacity(0.1),
// //           ),
// //           child: Row(
// //             children: [
// //               Icon(icon, color: Colors.white, size: 28),
// //               SizedBox(width: 16),
// //               Text(
// //                 title,
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class DrawerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryDeepPurple,
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.primaryGradient),
//         child: SafeArea(
//           child: Column(
//             children: [
//               _buildProfileSection(),
//               SizedBox(height: 30),
//               _buildMenuItems(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileSection() {
//     final user = FirebaseAuth.instance.currentUser;

//     return StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .doc(user?.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error loading profile'));
//         }

//         String userName = snapshot.data?.get('name') ?? 'User';
//         String email = user?.email ?? '';

//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppColors.secondaryWhite,
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondaryWhite.withOpacity(0.2),
//                       blurRadius: 12,
//                     ),
//                   ],
//                 ),
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundColor: AppColors.primarySoftBlue.withOpacity(0.3),
//                   child: Text(
//                     userName[0].toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 32,
//                       color: AppColors.secondaryWhite,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       userName,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondaryWhite,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       email,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppColors.secondaryWhite.withOpacity(0.7),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildMenuItems() {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.secondaryWhite.withOpacity(0.1),
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           child: ListView(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             children: [
//               _buildMenuItem(
//                 icon: Icons.home_outlined,
//                 title: 'Home',
//                 onTap: () => Get.toNamed('/home'),
//               ),
//               _buildMenuItem(
//                 icon: Icons.map_outlined,
//                 title: 'Map',
//                 onTap: () => Get.toNamed('/map'),
//               ),
//               _buildMenuItem(
//                 icon: Icons.event_outlined,
//                 title: 'Events',
//                 onTap: () => Get.toNamed('/events'),
//               ),
//               _buildMenuItem(
//                 icon: Icons.person_outline,
//                 title: 'Profile',
//                 onTap: () => Get.toNamed('/profile'),
//               ),
//               Divider(color: AppColors.secondaryWhite.withOpacity(0.2)),
//               _buildMenuItem(
//                 icon: Icons.settings_outlined,
//                 title: 'Settings',
//                 onTap: () => Get.toNamed('/settings'),
//               ),
//               _buildMenuItem(
//                 icon: Icons.logout,
//                 title: 'Logout',
//                 onTap: () async {
//                   await FirebaseAuth.instance.signOut();
//                   Get.offAllNamed('/login');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: AppColors.secondaryWhite, size: 24),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: AppColors.secondaryWhite,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       onTap: onTap,
//       contentPadding: EdgeInsets.symmetric(horizontal: 24),
//       hoverColor: AppColors.secondaryWhite.withOpacity(0.1),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhub/controller/AuthServices.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();

  AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeepPurple,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildProfileSection(),
              const SizedBox(height: 24),
              Expanded(child: _buildMenuSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        final userName = snapshot.data?.get('name') ?? 'User';
        final email = user?.email ?? '';

        return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondaryWhite,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryWhite.withOpacity(0.2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primarySoftBlue.withOpacity(0.3),
                  child: Text(
                    userName[0].toUpperCase(),
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.secondaryWhite,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.secondaryWhite,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.secondaryWhite.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            _buildMenuItem(
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () => Get.toNamed('/home'),
            ),
            _buildMenuItem(
              icon: Icons.map_outlined,
              title: 'Map',
              onTap: () => Get.toNamed('/home'),
            ),
            _buildMenuItem(
              icon: Icons.event_outlined,
              title: 'Events',
              onTap: () => Get.toNamed('/event'),
            ),
            _buildMenuItem(
                icon: Icons.person_outline, title: 'Profile', onTap: () => {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Divider(
                color: AppColors.secondaryWhite.withOpacity(0.2),
                height: 1,
              ),
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => {
                // Get.toNamed('/settings')
              },
            ),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              isDestructive: true,
              onTap: () async {
                _authService.signOut();
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              isDestructive ? AppColors.accentOrange : AppColors.secondaryWhite,
          size: 24,
        ),
        title: Text(
          title,
          style: AppTextStyles.body1.copyWith(
            color: isDestructive
                ? AppColors.accentOrange
                : AppColors.secondaryWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: onTap,
        hoverColor: AppColors.secondaryWhite.withOpacity(0.1),
      ),
    );
  }
}
