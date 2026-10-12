import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Fraunces for display, DM Mono for data, system for body.
class AppText {
  static TextStyle displayLarge(BuildContext context) =>
      GoogleFonts.fraunces(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -1.0,
        color: AppColors.ink,
      );

  static TextStyle displayMedium(BuildContext context) =>
      GoogleFonts.fraunces(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: AppColors.ink,
      );

  static TextStyle displaySmall(BuildContext context) =>
      GoogleFonts.fraunces(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      );

  static TextStyle monoLabel({Color color = AppColors.muted}) =>
      GoogleFonts.dmMono(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        color: color,
      );

  static TextStyle monoValue({Color color = AppColors.ink}) =>
      GoogleFonts.dmMono(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle body(BuildContext context) => TextStyle(
        fontSize: 14,
        height: 1.5,
        color: AppColors.muted,
        fontFamily: 'Arial',
      );
}
