import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

/// App theme configuration with professional design system
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Main dark theme for the portfolio
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.accentColor,
        secondary: AppConstants.accentColor,
        surface: AppConstants.cardBackground,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppConstants.primaryText,
        error: AppConstants.errorColor,
        onError: Colors.white,
      ),

      // Scaffold background
      scaffoldBackgroundColor: AppConstants.primaryBackground,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSizeH4,
          fontWeight: FontWeight.w600,
          color: AppConstants.primaryText,
        ),
        iconTheme: const IconThemeData(
          color: AppConstants.primaryText,
          size: AppConstants.iconSizeMD,
        ),
      ),

      // Text theme
      textTheme: _buildTextTheme(),

      // Button themes
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),

      // Input decoration theme
      inputDecorationTheme: _buildInputDecorationTheme(),

      // Card theme
      cardTheme: CardThemeData(
        color: AppConstants.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          side: const BorderSide(color: AppConstants.borderColor, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppConstants.borderColor,
        thickness: 1,
        space: 1,
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppConstants.primaryText,
        size: AppConstants.iconSizeMD,
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppConstants.cardBackground,
        labelStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSizeBodySmall,
          color: AppConstants.primaryText,
        ),
        side: const BorderSide(color: AppConstants.borderColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
      ),

      // Tooltip theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppConstants.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          border: Border.all(color: AppConstants.borderColor),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSizeBodySmall,
          color: AppConstants.primaryText,
        ),
      ),
    );
  }

  /// Build text theme with Google Fonts
  static TextTheme _buildTextTheme() {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeDisplay,
        fontWeight: FontWeight.w700,
        color: AppConstants.primaryText,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeH1,
        fontWeight: FontWeight.w700,
        color: AppConstants.primaryText,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeH2,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.3,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeH2,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeH3,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeH4,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.4,
      ),

      // Title styles
      titleLarge: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeH4,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBodyLarge,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBody,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.4,
      ),

      // Body styles
      bodyLarge: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBodyLarge,
        fontWeight: FontWeight.w400,
        color: AppConstants.primaryText,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBody,
        fontWeight: FontWeight.w400,
        color: AppConstants.primaryText,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBodySmall,
        fontWeight: FontWeight.w400,
        color: AppConstants.secondaryText,
        height: 1.5,
      ),

      // Label styles
      labelLarge: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBody,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBodySmall,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryText,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeCaption,
        fontWeight: FontWeight.w600,
        color: AppConstants.secondaryText,
        height: 1.4,
      ),
    );
  }

  /// Build elevated button theme
  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            backgroundColor: AppConstants.accentColor,
            foregroundColor: Colors.black,
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: const Size(0, AppConstants.buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.white.withValues(alpha: 0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return Colors.white.withValues(alpha: 0.2);
              }
              return null;
            }),
          ),
    );
  }

  /// Build outlined button theme
  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style:
          OutlinedButton.styleFrom(
            foregroundColor: AppConstants.accentColor,
            minimumSize: const Size(0, AppConstants.buttonHeight),
            side: const BorderSide(color: AppConstants.accentColor, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return AppConstants.accentColor.withValues(alpha: 0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return AppConstants.accentColor.withValues(alpha: 0.2);
              }
              return null;
            }),
          ),
    );
  }

  /// Build text button theme
  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style:
          TextButton.styleFrom(
            foregroundColor: AppConstants.accentColor,
            minimumSize: const Size(0, AppConstants.buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return AppConstants.accentColor.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return AppConstants.accentColor.withOpacity(0.2);
              }
              return null;
            }),
          ),
    );
  }

  /// Build input decoration theme
  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppConstants.cardBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        borderSide: const BorderSide(color: AppConstants.borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        borderSide: const BorderSide(color: AppConstants.borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        borderSide: const BorderSide(color: AppConstants.accentColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        borderSide: const BorderSide(color: AppConstants.errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        borderSide: const BorderSide(color: AppConstants.errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMD,
        vertical: AppConstants.spaceMD,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBody,
        color: AppConstants.mutedText,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBody,
        color: AppConstants.secondaryText,
      ),
    );
  }
}
