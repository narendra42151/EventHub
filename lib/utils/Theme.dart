import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primaryDeepPurple = Color(0xFF5146FF);
  static const primarySoftBlue = Color(0xFF6A8DFF);

  // Secondary Colors
  static const secondaryLightBlue = Color(0xFFE4ECFF);
  static const secondaryWhite = Color(0xFFFFFFFF);

  // Accent Colors
  static const accentOrange = Color(0xFFFFA726);
  static const accentLightGrey = Color(0xFFF5F5F5);

  // Text Colors
  static const textDarkBlue = Color(0xFF293460);
  static const textGrey = Color(0xFF8A92A6);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [primaryDeepPurple, primarySoftBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [accentOrange, Color(0xFFFFC107)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textDarkBlue,
  );

  static const body1 = TextStyle(
    fontSize: 16,
    color: AppColors.textGrey,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryWhite,
  );
}

class AppDecorations {
  static final cardDecoration = BoxDecoration(
    color: AppColors.secondaryWhite,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDeepPurple.withOpacity(0.1),
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  static final buttonDecoration = BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDeepPurple.withOpacity(0.3),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  );
}
