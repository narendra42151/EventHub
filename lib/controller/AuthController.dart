import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final isLoading = false.obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(auth.currentUser);
  //   _user.bindStream(auth.authStateChanges());
  //   ever(_user, _initialScreen);
  // }

  // _initialScreen(User? user) async {
  //   if (user == null) {
  //     Get.offAllNamed('/login');
  //   } else {
  //     try {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.uid)
  //           .get();
  //       Get.offAllNamed('/home');
  //     } catch (e) {
  //       await auth.signOut();
  //       Get.offAllNamed('/login');
  //     }
  //   }
  // }

  // void checkAuth() {
  //   if (!Get.currentRoute.contains('/login') &&
  //       !Get.currentRoute.contains('/home')) {
  //     if (auth.currentUser != null) {
  //       Get.offAllNamed('/home');
  //     } else {
  //       Get.offAllNamed('/login');
  //     }
  //   }
  // }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out');
    }
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    try {
      isLoading.value = true;
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Authentication failed',
        backgroundColor: Colors.red[100],
      );
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String confirmPassword,
    String name,
  ) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Sign up failed',
        backgroundColor: Colors.red[100],
      );
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    try {
      isLoading.value = true;
      await auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent',
        backgroundColor: Colors.green[100],
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Failed to send reset email',
        backgroundColor: Colors.red[100],
      );
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}
