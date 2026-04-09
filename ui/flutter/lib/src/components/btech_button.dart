import 'package:flutter/material.dart';
import 'package:btech_tokens/btech_tokens.dart';

enum BtechButtonVariant { primary, secondary, ghost }

enum BtechButtonSize { sm, md, lg }

class BtechButton extends StatelessWidget {
  const BtechButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = BtechButtonVariant.primary,
    this.size = BtechButtonSize.md,
    this.disabled = false,
    this.child,
  });

  final String label;
  final VoidCallback? onPressed;
  final BtechButtonVariant variant;
  final BtechButtonSize size;
  final bool disabled;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    final effectiveOnPressed = disabled ? null : onPressed;

    switch (variant) {
      case BtechButtonVariant.primary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: _primaryStyle(),
          child: child ?? Text(label),
        );
      case BtechButtonVariant.secondary:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: _secondaryStyle(),
          child: child ?? Text(label),
        );
      case BtechButtonVariant.ghost:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: _ghostStyle(),
          child: child ?? Text(label),
        );
    }
  }

  ButtonStyle _primaryStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTokens.primary,
      foregroundColor: AppTokens.primaryForeground,
      disabledBackgroundColor: AppTokens.muted,
      disabledForegroundColor: AppTokens.mutedForeground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: _padding,
      textStyle: TextStyle(
        fontSize: _fontSize,
        fontWeight: AppTokens.fontWeightMedium,
      ),
    );
  }

  ButtonStyle _secondaryStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: AppTokens.secondaryForeground,
      disabledForegroundColor: AppTokens.mutedForeground,
      side: const BorderSide(color: AppTokens.border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: _padding,
      textStyle: TextStyle(
        fontSize: _fontSize,
        fontWeight: AppTokens.fontWeightMedium,
      ),
    );
  }

  ButtonStyle _ghostStyle() {
    return TextButton.styleFrom(
      foregroundColor: AppTokens.accentForeground,
      disabledForegroundColor: AppTokens.mutedForeground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: _padding,
      textStyle: TextStyle(
        fontSize: _fontSize,
        fontWeight: AppTokens.fontWeightMedium,
      ),
    );
  }

  double get _borderRadius {
    switch (size) {
      case BtechButtonSize.sm:
        return AppTokens.radiusSm;
      case BtechButtonSize.md:
      case BtechButtonSize.lg:
        return AppTokens.radiusMd;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case BtechButtonSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: AppTokens.spacing2,
          vertical: AppTokens.spacing1,
        );
      case BtechButtonSize.md:
        return const EdgeInsets.symmetric(
          horizontal: AppTokens.spacing4,
          vertical: AppTokens.spacing2,
        );
      case BtechButtonSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: AppTokens.spacing6,
          vertical: AppTokens.spacing4,
        );
    }
  }

  double get _fontSize {
    switch (size) {
      case BtechButtonSize.sm:
        return AppTokens.fontSizeXs;
      case BtechButtonSize.md:
        return AppTokens.fontSizeSm;
      case BtechButtonSize.lg:
        return AppTokens.fontSizeBase;
    }
  }
}
