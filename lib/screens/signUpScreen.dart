import 'package:eventhub/controller/AuthServices.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final isLoading = false.obs;
  final AuthService authService = AuthService(); // Use AuthService

  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: 40),
//                 Icon(
//                   Icons.person_add_outlined,
//                   size: 100,
//                   color: Colors.blue[900],
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Create Account',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[900],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Sign up to get started',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 CustomTextField(
//                   controller: nameController,
//                   labelText: "Name",
//                   prefixIcon: Icons.person,
//                   isPassword: false,
//                 ),
//                 SizedBox(height: 20),
//                 CustomTextField(
//                   controller: emailController,
//                   labelText: "Email",
//                   prefixIcon: Icons.email,
//                   isPassword: false,
//                 ),
//                 SizedBox(height: 20),
//                 CustomTextField(
//                   controller: passwordController,
//                   labelText: "Password",
//                   prefixIcon: Icons.lock_outline,
//                   isPassword: true,
//                 ),
//                 SizedBox(height: 20),
//                 CustomTextField(
//                   controller: confirmPasswordController,
//                   labelText: "Confirm Password",
//                   prefixIcon: Icons.lock_outline,
//                   isPassword: true,
//                 ),
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
//                                 // Validate if passwords match
//                                 if (passwordController.text !=
//                                     confirmPasswordController.text) {
//                                   Get.snackbar(
//                                       'Error', 'Passwords do not match!',
//                                       snackPosition: SnackPosition.BOTTOM);
//                                   return;
//                                 }

//                                 try {
//                                   // Start loading
//                                   authService.isLoading.value = true;

//                                   // Call register method from AuthService
//                                   await authService.registerWithEmail(
//                                     emailController.text,
//                                     passwordController.text,
//                                     nameController.text,
//                                   );

//                                   // Navigate to login or home page after successful registration
//                                   Get.offNamed(
//                                       '/login'); // Replace with actual route
//                                 } catch (e) {
//                                   // Show error message
//                                   Get.snackbar(
//                                       'Registration Error', e.toString(),
//                                       snackPosition: SnackPosition.BOTTOM);
//                                 } finally {
//                                   // Stop loading
//                                   authService.isLoading.value = false;
//                                 }
//                               },
//                         child: authService.isLoading.value
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                       ),
//                     )),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Already have an account?'),
//                     TextButton(
//                       onPressed: () => Get.back(),
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Colors.blue[900],
//                           fontWeight: FontWeight.bold,
//                         ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeepPurple,
      body: Container(
        //  decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                // SizedBox(height: 20),
                _buildHeader(),
                SizedBox(height: 10),
                _buildSignUpCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
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
      child: Icon(
        Icons.person_add_outlined,
        size: 80,
        color: AppColors.secondaryWhite,
      ),
    );
  }

  Widget _buildSignUpCard() {
    return Container(
      decoration: AppDecorations.cardDecoration,
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text('Create Account', style: AppTextStyles.heading1),
          SizedBox(height: 10),
          Text('Sign up to get started', style: AppTextStyles.body1),
          SizedBox(height: 30),
          _buildTextField(
            controller: nameController,
            hint: 'Name',
            icon: Icons.person_outline,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: emailController,
            hint: 'Email',
            icon: Icons.email_outlined,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: passwordController,
            hint: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: confirmPasswordController,
            hint: 'Confirm Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          SizedBox(height: 30),
          _buildSignUpButton(),
          SizedBox(height: 20),
          _buildLoginLink(),
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
        style: TextStyle(color: AppColors.textDarkBlue),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textGrey),
          prefixIcon: Icon(icon, color: AppColors.primaryDeepPurple),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Obx(() => Container(
          width: double.infinity,
          height: 55,
          decoration: AppDecorations.buttonDecoration,
          child: ElevatedButton(
            onPressed: authService.isLoading.value ? null : _handleSignUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: authService.isLoading.value
                ? CircularProgressIndicator(color: AppColors.secondaryWhite)
                : Text('Sign Up', style: AppTextStyles.buttonText),
          ),
        ));
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?', style: AppTextStyles.body1),
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Login',
            style: TextStyle(
              color: AppColors.primaryDeepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match!');
      return;
    }
    try {
      authService.isLoading.value = true;
      await authService.registerWithEmail(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      authService.isLoading.value = false;
    }
  }
}
