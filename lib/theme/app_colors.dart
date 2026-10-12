import 'package:flutter/material.dart';

/// Palette D — Warm Beige + light multi-pastels (no navy / blue).
/// Warm beige bg, espresso ink, cocoa primary + peach / lilac / sage / butter / rose.
class AppColors {
  // Base
  static const bg = Color(0xFFF7EFE2); // warm beige
  static const surface = Color(0xFFFFFCF5); // warm white card
  static const ink = Color(0xFF3A2F28); // espresso text
  static const muted = Color(0xFF8A7B6E); // warm gray
  static const track = Color(0xFFEADDCB);
  static const border = Color(0xFFEADDCB);

  // Primary (replaces navy) — warm cocoa
  static const cocoa = Color(0xFF5C4033);
  static const navy = cocoa; // compat alias — do not use blue anymore
  static const tint = Color(0xFFFFE3C9); // compat alias -> peach bg

  // Accents
  static const terracotta = Color(0xFFC96A3B);
  static const amber = terracotta; // compat alias
  static const amberBg = Color(0xFFFBE3A7); // compat -> butter

  static const peach = Color(0xFFFFD9BE);
  static const peachBg = Color(0xFFFFE9D6);
  static const peachText = Color(0xFF9A4A1F);

  static const lilac = Color(0xFFE0D4F5);
  static const lilacBg = Color(0xFFEFE7FB);
  static const lilacText = Color(0xFF6B4FA1);

  static const sage = Color(0xFFCDE3BD);
  static const green = Color(0xFF3E7A44); // compat — moss
  static const greenBg = Color(0xFFDDEDCB); // compat -> sage bg
  static const sageText = Color(0xFF3E7A44);

  static const butter = Color(0xFFFBE3A7);
  static const butterBg = Color(0xFFFFF0C6);
  static const butterText = Color(0xFF8A5A00);

  static const rose = Color(0xFFF6C6B8);
  static const roseBg = Color(0xFFFDE3DA);
  static const roseText = Color(0xFFA34A3A);
  static const red = Color(0xFFC14A3A);

  /// Cycle pastel bgs for cards / chips.
  static const pastelBgs = [
    peachBg,
    lilacBg,
    greenBg,
    butterBg,
    roseBg,
  ];

  static Color pastelFor(int index) => pastelBgs[index % pastelBgs.length];
}
