import 'package:flutter/material.dart';
import 'constants.dart';

/// Device type enumeration
enum DeviceType { mobile, tablet, desktop, largeDesktop }

/// Responsive utility class for handling different screen sizes
class Responsive {
  // Private constructor to prevent instantiation
  Responsive._();

  /// Get device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= AppConstants.breakpointLargeDesktop) {
      return DeviceType.largeDesktop;
    } else if (width >= AppConstants.breakpointDesktop) {
      return DeviceType.desktop;
    } else if (width >= AppConstants.breakpointTablet) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    final deviceType = getDeviceType(context);
    return deviceType == DeviceType.desktop ||
        deviceType == DeviceType.largeDesktop;
  }

  /// Check if device is large desktop
  static bool isLargeDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.largeDesktop;
  }

  /// Get responsive value based on device type
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets padding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: value(
        context,
        mobile: AppConstants.spaceMD,
        tablet: AppConstants.spaceLG,
        desktop: AppConstants.spaceXL,
      ),
      vertical: value(
        context,
        mobile: AppConstants.spaceMD,
        tablet: AppConstants.spaceLG,
        desktop: AppConstants.spaceLG,
      ),
    );
  }

  /// Get responsive section padding
  static EdgeInsets sectionPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: value(
        context,
        mobile: AppConstants.spaceMD,
        tablet: AppConstants.spaceXL,
        desktop: AppConstants.spaceXXL,
      ),
      vertical: value(
        context,
        mobile: AppConstants.spaceXL,
        tablet: AppConstants.spaceXXL,
        desktop: AppConstants.sectionSpacing,
      ),
    );
  }

  /// Get responsive grid columns
  static int gridColumns(BuildContext context) {
    return value(
      context,
      mobile: AppConstants.gridColumnsMobile,
      tablet: AppConstants.gridColumnsTablet,
      desktop: AppConstants.gridColumnsDesktop,
    );
  }

  /// Get responsive font size
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return value(context, mobile: mobile, tablet: tablet, desktop: desktop);
  }

  /// Get responsive spacing
  static double spacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return value(context, mobile: mobile, tablet: tablet, desktop: desktop);
  }

  /// Get maximum content width with responsive constraints
  static double maxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = value(
      context,
      mobile: screenWidth,
      tablet: screenWidth * 0.9,
      desktop: AppConstants.maxContentWidth,
    );

    return maxWidth.clamp(0.0, AppConstants.maxContentWidth);
  }

  /// Get responsive aspect ratio
  static double aspectRatio(BuildContext context) {
    return value(context, mobile: 1.0, tablet: 1.2, desktop: 1.5);
  }
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final deviceType = Responsive.getDeviceType(context);
    return builder(context, deviceType);
  }
}

/// Responsive layout widget that shows different widgets based on screen size
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return mobile;
          case DeviceType.tablet:
            return tablet ?? mobile;
          case DeviceType.desktop:
            return desktop ?? tablet ?? mobile;
          case DeviceType.largeDesktop:
            return largeDesktop ?? desktop ?? tablet ?? mobile;
        }
      },
    );
  }
}

/// Responsive container with max width constraints
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool centerContent;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? Responsive.padding(context),
      child: centerContent
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.maxWidth(context),
                ),
                child: child,
              ),
            )
          : child,
    );
  }
}

/// Responsive grid view
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final double? runSpacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
  });

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(
      context,
      mobile: mobileColumns ?? AppConstants.gridColumnsMobile,
      tablet: tabletColumns ?? AppConstants.gridColumnsTablet,
      desktop: desktopColumns ?? AppConstants.gridColumnsDesktop,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemSpacing = spacing ?? AppConstants.gridGap;
        final totalSpacing = (columns - 1) * itemSpacing;
        final itemWidth = (constraints.maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing: itemSpacing,
          runSpacing: runSpacing ?? itemSpacing,
          children: children.map((child) {
            return SizedBox(width: itemWidth, child: child);
          }).toList(),
        );
      },
    );
  }
}

/// Extension on BuildContext for easy responsive access
extension ResponsiveContext on BuildContext {
  /// Get device type
  DeviceType get deviceType => Responsive.getDeviceType(this);

  /// Check if mobile
  bool get isMobile => Responsive.isMobile(this);

  /// Check if tablet
  bool get isTablet => Responsive.isTablet(this);

  /// Check if desktop
  bool get isDesktop => Responsive.isDesktop(this);

  /// Check if large desktop
  bool get isLargeDesktop => Responsive.isLargeDesktop(this);

  /// Get responsive value
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    return Responsive.value(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Get responsive padding
  EdgeInsets get responsivePadding => Responsive.padding(this);

  /// Get responsive section padding
  EdgeInsets get responsiveSectionPadding => Responsive.sectionPadding(this);

  /// Get responsive grid columns
  int get responsiveGridColumns => Responsive.gridColumns(this);

  /// Get responsive max width
  double get responsiveMaxWidth => Responsive.maxWidth(this);
}
