import 'package:flutter/material.dart';

/// App-wide constants for consistent design
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // ============================================================================
  // COLORS
  // ============================================================================

  /// Primary background color - Dark theme
  static const Color primaryBackground = Color(0xFF0D0D0D);

  /// Alternative dark background
  static const Color secondaryBackground = Color(0xFF121212);

  /// Accent color for CTAs, highlights, and interactive elements
  static const Color accentColor = Color.fromARGB(255, 255, 255, 255);

  /// Primary text color
  static const Color primaryText = Color(0xFFFFFFFF);

  /// Secondary text color
  static const Color secondaryText = Color(0xFFB0B0B0);

  /// Muted text color
  static const Color mutedText = Color(0xFF808080);

  /// Border color
  static const Color borderColor = Color(0xFF2A2A2A);

  /// Card background color
  static const Color cardBackground = Color(0xFF1A1A1A);

  /// Hover color for interactive elements
  static const Color hoverColor = Color(0xFF2A2A2A);

  /// Success color
  static const Color successColor = Color(0xFF4CAF50);

  /// Warning color
  static const Color warningColor = Color(0xFFFF9800);

  /// Error color
  static const Color errorColor = Color(0xFFF44336);

  // ============================================================================
  // SPACING
  // ============================================================================

  /// Extra small spacing (4px)
  static const double spaceXS = 4.0;

  /// Small spacing (8px)
  static const double spaceSM = 8.0;

  /// Medium spacing (16px)
  static const double spaceMD = 16.0;

  /// Large spacing (24px)
  static const double spaceLG = 24.0;

  /// Extra large spacing (32px)
  static const double spaceXL = 32.0;

  /// Extra extra large spacing (48px)
  static const double spaceXXL = 48.0;

  /// Section spacing (64px)
  static const double sectionSpacing = 64.0;

  /// Page padding horizontal
  static const double pagePaddingHorizontal = 32.0;

  /// Page padding vertical
  static const double pagePaddingVertical = 24.0;

  /// Section padding mobile
  static const double sectionPaddingMobile = 32.0;

  /// Section padding tablet
  static const double sectionPaddingTablet = 48.0;

  /// Section padding desktop
  static const double sectionPaddingDesktop = 64.0;

  // ============================================================================
  // TYPOGRAPHY
  // ============================================================================

  /// Display font size (48px)
  static const double fontSizeDisplay = 48.0;

  /// Heading 1 font size (36px)
  static const double fontSizeH1 = 36.0;

  /// Heading 2 font size (28px)
  static const double fontSizeH2 = 28.0;

  /// Heading 3 font size (24px)
  static const double fontSizeH3 = 24.0;

  /// Heading 4 font size (20px)
  static const double fontSizeH4 = 20.0;

  /// Large body font size (18px)
  static const double fontSizeBodyLarge = 18.0;

  /// Regular body font size (16px)
  static const double fontSizeBody = 16.0;

  /// Small body font size (14px)
  static const double fontSizeBodySmall = 14.0;

  /// Caption font size (12px)
  static const double fontSizeCaption = 12.0;

  // ============================================================================
  // BORDER RADIUS
  // ============================================================================

  /// Small border radius (4px)
  static const double radiusSM = 4.0;

  /// Medium border radius (8px)
  static const double radiusMD = 8.0;

  /// Large border radius (12px)
  static const double radiusLG = 12.0;

  /// Extra large border radius (16px)
  static const double radiusXL = 16.0;

  /// Circular border radius (999px)
  static const double radiusCircular = 999.0;

  // ============================================================================
  // BREAKPOINTS
  // ============================================================================

  /// Mobile breakpoint (768px)
  static const double breakpointMobile = 768.0;

  /// Tablet breakpoint (1024px)
  static const double breakpointTablet = 1024.0;

  /// Desktop breakpoint (1200px)
  static const double breakpointDesktop = 1200.0;

  /// Large desktop breakpoint (1440px)
  static const double breakpointLargeDesktop = 1440.0;

  // ============================================================================
  // ANIMATION DURATIONS
  // ============================================================================

  /// Fast animation duration (150ms)
  static const Duration animationFast = Duration(milliseconds: 150);

  /// Normal animation duration (200ms)
  static const Duration animationNormal = Duration(milliseconds: 200);

  /// Slow animation duration (300ms)
  static const Duration animationSlow = Duration(milliseconds: 300);

  /// Page transition duration (400ms)
  static const Duration animationPageTransition = Duration(milliseconds: 400);

  // ============================================================================
  // SHADOWS
  // ============================================================================

  /// Small shadow
  static const List<BoxShadow> shadowSM = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
  ];

  /// Medium shadow
  static const List<BoxShadow> shadowMD = [
    BoxShadow(color: Color(0x1F000000), blurRadius: 8, offset: Offset(0, 4)),
  ];

  /// Large shadow
  static const List<BoxShadow> shadowLG = [
    BoxShadow(color: Color(0x26000000), blurRadius: 16, offset: Offset(0, 8)),
  ];

  /// Extra large shadow
  static const List<BoxShadow> shadowXL = [
    BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, 12)),
  ];

  // ============================================================================
  // COMPONENT SIZES
  // ============================================================================

  /// Button height
  static const double buttonHeight = 48.0;

  /// Small button height
  static const double buttonHeightSmall = 36.0;

  /// Large button height
  static const double buttonHeightLarge = 56.0;

  /// Input field height
  static const double inputHeight = 48.0;

  /// Navigation bar height
  static const double navBarHeight = 72.0;

  /// Footer height
  static const double footerHeight = 120.0;

  /// Card minimum height
  static const double cardMinHeight = 200.0;

  /// Profile image size
  static const double profileImageSize = 120.0;

  /// Icon size small
  static const double iconSizeSM = 16.0;

  /// Icon size medium
  static const double iconSizeMD = 24.0;

  /// Icon size large
  static const double iconSizeLG = 32.0;

  /// Icon size extra large
  static const double iconSizeXL = 48.0;

  // ============================================================================
  // GRID LAYOUT
  // ============================================================================

  /// Maximum content width
  static const double maxContentWidth = 1200.0;

  /// Grid gap
  static const double gridGap = 24.0;

  /// Grid columns mobile
  static const int gridColumnsMobile = 1;

  /// Grid columns tablet
  static const int gridColumnsTablet = 2;

  /// Grid columns desktop
  static const int gridColumnsDesktop = 3;

  // ============================================================================
  // Z-INDEX
  // ============================================================================

  /// Navigation z-index
  static const int zIndexNavigation = 1000;

  /// Modal z-index
  static const int zIndexModal = 2000;

  /// Tooltip z-index
  static const int zIndexTooltip = 3000;
}
