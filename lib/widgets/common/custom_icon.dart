import 'package:flutter/material.dart';
import '../../utils/constants.dart';

/// Custom icon widget that uses the fevicon.jpeg instead of Material Icons
class CustomIcon extends StatelessWidget {
  final double size;
  final Color? color;
  final BoxFit fit;

  const CustomIcon({
    super.key,
    this.size = AppConstants.iconSizeMD,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ColorFiltered(
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: Image.asset(
          AppConstants.customIconPath,
          width: size,
          height: size,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to a simple container if image fails to load
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color ?? AppConstants.accentColor,
                borderRadius: BorderRadius.circular(size * 0.1),
              ),
              child: Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom icon button that uses the fevicon.jpeg
class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final String? tooltip;
  final double splashRadius;

  const CustomIconButton({
    super.key,
    this.onPressed,
    this.size = AppConstants.iconSizeMD,
    this.color,
    this.tooltip,
    this.splashRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      splashRadius: splashRadius,
      icon: CustomIcon(
        size: size,
        color: color,
      ),
    );
  }
}
