import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized Streamflix color palette and text styles — a deep
/// navy-blue "night mode" identity (near-black backgrounds, a calm,
/// muted blue accent for buttons/highlights, and a slightly lighter
/// blue for links/focus states) instead of neon violet/cyan.
class StreamflixColors {
  static const Color black = Color(0xFF000000);
  static const Color nearBlack = Color(0xFF060B14);
  static const Color darkGrey = Color(0xFF0A1626);
  static const Color fieldGrey = Color(0xFF13253B);

  // Primary brand accent — a deep, muted blue (not neon).
  static const Color primary = Color(0xFF0E4A8A);
  static const Color primaryDark = Color(0xFF082D57);

  // Secondary accent, used for glows, borders, and highlights — a
  // muted mid-blue, still a touch lighter than primary for contrast.
  static const Color secondary = Color(0xFF3D6FB0);

  static const Color error = Color(0xFFFF2E63);
  static const Color grey = Color(0xFF8CA3C4);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );
}

class StreamflixTextStyles {
  static TextStyle get logo => GoogleFonts.orbitron(
        color: StreamflixColors.white,
        fontSize: 36,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      );

  static TextStyle get heading => GoogleFonts.orbitron(
        color: StreamflixColors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      );

  static TextStyle get body => GoogleFonts.rajdhani(
        color: StreamflixColors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get greyBody => GoogleFonts.rajdhani(
        color: StreamflixColors.grey,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get link => GoogleFonts.rajdhani(
        color: StreamflixColors.secondary,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
      );
}

/// Reusable input decoration so every text field on every screen looks
/// identical (deep violet filled box, lavender label, cyan neon focus
/// glow instead of a plain red underline).
InputDecoration streamflixInputDecoration(String label) {
  return InputDecoration(
    filled: true,
    fillColor: StreamflixColors.fieldGrey,
    labelText: label,
    labelStyle: GoogleFonts.rajdhani(
      color: StreamflixColors.grey,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: StreamflixColors.secondary, width: 1.4),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: StreamflixColors.error, width: 1.2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: StreamflixColors.error, width: 1.4),
    ),
    errorStyle: GoogleFonts.rajdhani(color: StreamflixColors.error, fontSize: 12),
  );
}

/// Reusable neon "Streamflix button" (Login / Sign Up buttons) — a
/// flat magenta fill with cyan text instead of a plain solid red
/// button, matching the new cyberpunk identity.
ButtonStyle streamflixButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: StreamflixColors.primary,
    foregroundColor: StreamflixColors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    textStyle: GoogleFonts.rajdhani(fontSize: 17, fontWeight: FontWeight.w700),
    elevation: 0,
  );
}
