import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = false.obs;
  // Register with email and password
  Future<void> registerWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Persist signed-in state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userState', 'signed_in');
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "An unknown error occurred.";
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!userCredential.user!.emailVerified) {
        throw "Please verify your email before signing in.";
      }

      // Persist logged-in state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userState', 'logged_in');
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "An unknown error occurred.";
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email.trim());
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

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();

    // Clear user state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userState', 'logged_out');
  }
}
