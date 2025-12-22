// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sublime/controller/AuthServices.dart';
// import 'package:sublime/widgets/customTextField.dart';

// class LoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final isLoading = false.obs;
//   final AuthService authService = AuthService(); // Use AuthService

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(height: 50),
//                 Icon(
//                   Icons.lock_outlined,
//                   size: 100,
//                   color: Colors.blue[900],
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Welcome Back',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[900],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Sign in to continue',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(height: 50),
//                 CustomTextField(
//                     controller: emailController,
//                     labelText: "Email",
//                     prefixIcon: Icons.email,
//                     isPassword: false),
//                 SizedBox(height: 20),
//                 CustomTextField(
//                     controller: passwordController,
//                     labelText: "Password",
//                     prefixIcon: Icons.lock,
//                     isPassword: true),
//                 SizedBox(height: 30),
//                 Obx(() => SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           backgroundColor: Colors.blue[700],
//                         ),
//                         onPressed: authService.isLoading.value
//                             ? null
//                             : () async {
//                                 try {
//                                   // Start loading
//                                   authService.isLoading.value = true;

//                                   // Call the login method from AuthService
//                                   await authService.signInWithEmail(
//                                     emailController.text,
//                                     passwordController.text,
//                                   );

//                                   // Navigate to the home page or another screen
//                                   Get.offNamed(
//                                       '/home'); // Replace with actual home route
//                                 } catch (e) {
//                                   // Show error message
//                                   Get.snackbar('Login Error', e.toString(),
//                                       snackPosition: SnackPosition.BOTTOM);
//                                 } finally {
//                                   // Stop loading
//                                   authService.isLoading.value = false;
//                                 }
//                               },
//                         child: authService.isLoading.value
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text(
//                                 'Login',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                       ),
//                     )),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: () => Get.toNamed('/forgot_password'),
//                       child: Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Colors.blue[900]),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () => Get.toNamed('/signup'),
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(color: Colors.blue[900]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:eventhub/controller/AuthServices.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;
  final AuthService authService = AuthService();

  LoginPage({super.key}); // Use AuthService

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeepPurple,
      body: Container(
        //    decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 30),
                _buildLogo(),
                const SizedBox(height: 40),
                _buildLoginCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDeepPurple.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.person,
        size: 80,
        color: AppColors.primaryDeepPurple,
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      decoration: AppDecorations.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('Welcome Back', style: AppTextStyles.heading1),
          const SizedBox(height: 10),
          const Text('Sign in to continue', style: AppTextStyles.body1),
          const SizedBox(height: 30),
          _buildTextField(
            controller: emailController,
            hint: 'Email',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: passwordController,
            hint: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          _buildForgotPassword(),
          const SizedBox(height: 30),
          _buildLoginButton(),
          // SizedBox(height: 20),
          // _buildDivider(),
          const SizedBox(height: 20),
          //_buildGoogleSignIn(),
          const SizedBox(height: 20),
          _buildSignUpLink(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accentLightGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: AppColors.textDarkBlue),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textGrey),
          prefixIcon: Icon(icon, color: AppColors.primaryDeepPurple),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(() => Container(
          width: double.infinity,
          height: 55,
          decoration: AppDecorations.buttonDecoration,
          child: ElevatedButton(
            onPressed: authService.isLoading.value
                ? null
                : () async {
                    try {
                      // Start loading
                      isLoading.value = true;

                      // Small delay to allow SpinKit to render
                      await Future.delayed(const Duration(milliseconds: 200));

                      // Call the login method from AuthService
                      await authService.signInWithEmail(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      // Navigate to the home page or another screen
                      Get.offNamed('/home'); // Replace with actual home route
                    } catch (e) {
                      // Show error message
                      Get.snackbar(
                        'Login Error',
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } finally {
                      // Stop loading
                      isLoading.value = false;
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: isLoading.value
                ? const SpinKitSpinningLines(
                    color: AppColors
                        .primaryDeepPurple, // Primary color for the spinner
                    size: 50.0, // Size of the spinner
                    lineWidth: 3.0, // Thickness of the lines
                  )
                : const Text('Login', style: AppTextStyles.buttonText),
          ),
        ));
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Get.toNamed('/forgot_password'),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: AppColors.primaryDeepPurple),
        ),
      ),
    );
  }

  // Widget _buildGoogleSignIn() {
  //   return ElevatedButton.icon(
  //     icon: Image.asset('assets/google_icon.png', height: 24),
  //     label: Text('Sign in with Google',
  //         style: TextStyle(color: AppColors.textDarkBlue)),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: AppColors.secondaryWhite,
  //       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         side: BorderSide(color: AppColors.accentLightGrey),
  //       ),
  //     ),
  //     onPressed: () {},
  //   );
  // }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: AppTextStyles.body1),
        TextButton(
          onPressed: () => Get.offNamed('/signup'),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.primaryDeepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.accentLightGrey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR', style: AppTextStyles.body1),
        ),
        Expanded(child: Divider(color: AppColors.accentLightGrey)),
      ],
    );
  }
}
