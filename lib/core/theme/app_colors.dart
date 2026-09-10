
// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Colors (Nautical & Oceanic Theme)
  static const Color primaryOcean = Color(0xFF0F4C81);   // Deep Sea Blue
  static const Color secondaryTeal = Color(0xFF00A896);  // Coastal Teal
  static const Color accentCoral = Color(0xFFF4A261);    // Coral / Sun Gold

  // Neutral Light
  static const Color lightBackground = Color(0xFFF4F7F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF191C1E);

  // Neutral Dark
  static const Color darkBackground = Color(0xFF0A1118); // Deep Abyss
  static const Color darkSurface = Color(0xFF121B24);
  static const Color darkOnSurface = Color(0xFFE1E2E5);
}