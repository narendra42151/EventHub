// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sublime/controller/AuthController.dart';
// import 'package:sublime/controller/AuthServices.dart';

// class ForgotPasswordPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final isLoading = false.obs;
//   final AuthController authController = Get.find<AuthController>();
//   final AuthService authService = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Icon(
//                   Icons.lock_reset,
//                   size: 80,
//                   color: Colors.blue[900],
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Forgot Password?',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[900],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Enter your email to reset your password',
//                   style: TextStyle(
//                     color: Colors.grey[700],
//                     fontSize: 16,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.8),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 SizedBox(height: 24),
//                 Obx(() => SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           backgroundColor: Colors.blue[700],
//                         ),
//                         onPressed: authService.isLoading.value
//                             ? null
//                             : () =>
//                                 authService.resetPassword(emailController.text),
//                         child: Obx(() => authService.isLoading.value
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text(
//                                 'Reset Password',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               )),
//                       ),
//                     )),
//                 SizedBox(height: 16),
//                 TextButton(
//                   onPressed: () => Get.back(),
//                   child: Text('Back to Login'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:eventhub/controller/AuthController.dart';
import 'package:eventhub/controller/AuthServices.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final isLoading = false.obs;
  final AuthController authController = Get.find<AuthController>();
  final AuthService authService = AuthService();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeepPurple,
      body: Container(
        // decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _buildIcon(),
                  const SizedBox(height: 40),
                  _buildResetCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.secondaryWhite.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDeepPurple.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.lock_reset,
        size: 80,
        color: AppColors.secondaryWhite,
      ),
    );
  }

  Widget _buildResetCard() {
    return Container(
      decoration: AppDecorations.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('Forgot Password?', style: AppTextStyles.heading1),
          const SizedBox(height: 10),
          const Text(
            'Enter your email to reset your password',
            style: AppTextStyles.body1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          _buildEmailField(),
          const SizedBox(height: 30),
          _buildResetButton(),
          const SizedBox(height: 20),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accentLightGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: emailController,
        style: const TextStyle(color: AppColors.textDarkBlue),
        decoration: const InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: AppColors.textGrey),
          prefixIcon:
              Icon(Icons.email_outlined, color: AppColors.primaryDeepPurple),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return Obx(() => Container(
          width: double.infinity,
          height: 55,
          decoration: AppDecorations.buttonDecoration,
          child: ElevatedButton(
            onPressed: authService.isLoading.value
                ? null
                : () => authService.resetPassword(emailController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: authService.isLoading.value
                ? const CircularProgressIndicator(
                    color: AppColors.secondaryWhite)
                : const Text('Reset Password', style: AppTextStyles.buttonText),
          ),
        ));
  }

  Widget _buildBackButton() {
    return TextButton(
      onPressed: () => Get.back(),
      child: const Text(
        'Back to Login',
        style: TextStyle(
          color: AppColors.primaryDeepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
