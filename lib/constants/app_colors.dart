import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Professional Dark Theme)
  static const Color primary = Color(0xFF6366F1);       // Indigo
  static const Color secondary = Color(0xFF8B5CF6);     // Purple
  static const Color tertiary = Color(0xFF4338CA);      // Deep Indigo

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF667eea),
    Color(0xFF764ba2),
  ];

  static const List<Color> headerGradient = [
    primary,
    secondary,
  ];

  // Glassmorphism Colors
  static const Color glassWhite = Color(0x40FFFFFF);
  static const Color glassDark = Color(0x20000000);
  static const Color glassLight = Color(0x60FFFFFF);
  static const Color glassBorder = Color(0x30FFFFFF);

  // Dark Gradient Background
  static const Color darkBg1 = Color(0xFF0F0C29);
  static const Color darkBg2 = Color(0xFF302B63);
  static const Color darkBg3 = Color(0xFF24243E);

  // Accent Colors
  static const Color accent = Color(0xFFEC4899);        // Pink
  static const Color success = Color(0xFF10B981);       // Green
  static const Color warning = Color(0xFFF59E0B);       // Amber
  static const Color error = Color(0xFFEF4444);         // Red

  // Neutral Colors
  static const Color white = Colors.white;
  static const Color black = Color(0xFF1F2937);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);

  // Background
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBackground = Colors.white;

  // Gradients
  static LinearGradient get splashGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF667eea),
      Color(0xFF764ba2),
      Color(0xFFf093fb),
    ],
  );

  static LinearGradient get darkGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkBg1, darkBg2, darkBg3],
  );

  static LinearGradient get headerGradientLR => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: headerGradient,
  );

  static LinearGradient get cardGradient => const LinearGradient(
    colors: [primary, secondary],
  );

  static LinearGradient get glassGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: 0.2),
      Colors.white.withValues(alpha: 0.05),
    ],
  );

  // Glass decoration for cards
  static BoxDecoration glassDecoration({
    double borderRadius = 20,
    Color? borderColor,
  }) {
    return BoxDecoration(
      gradient: glassGradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? glassBorder,
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  // Professional button gradient
  static LinearGradient get buttonGradient => const LinearGradient(
    colors: [
      Color(0xFF667eea),
      Color(0xFF764ba2),
    ],
  );
}
