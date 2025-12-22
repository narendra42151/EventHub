import 'dart:ui';

import 'package:flutter/material.dart';

// Common theme colors
class EventsAppTheme {
  static const Color primaryColor = Color(0xFF4D3AFF); // Vibrant purple
  static const Color accentColor = Color(0xFF00E1D9); // Turquoise
  static const Color darkColor = Color(0xFF1A1B25); // Dark background
  static const Color cardColor = Color(0xFF2A2B35); // Slightly lighter dark

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A1B25), // Dark blue-grey
      Color(0xFF2D1863), // Deep purple
      Color(0xFF1A1B25), // Dark blue-grey
    ],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF4D3AFF), // Vibrant purple
      Color(0xFF00E1D9), // Turquoise
    ],
  );
}

// Common base widget for glass card effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(30),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border:
                Border.all(color: EventsAppTheme.accentColor.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: EventsAppTheme.accentColor.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: -5,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// Common styled text field
class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;

  const StyledTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    super.key,
  });

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
        style: const TextStyle(color: Colors.white),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: Icon(icon, color: EventsAppTheme.accentColor),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}

// Common gradient button
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const GradientButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: EventsAppTheme.buttonGradient,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: EventsAppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
