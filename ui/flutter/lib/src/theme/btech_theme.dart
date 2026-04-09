import 'package:flutter/material.dart';
import 'package:btech_tokens/btech_tokens.dart';

class BtechTheme {
  BtechTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTokens.fontFamilySans,
      colorScheme: const ColorScheme.light(
        primary: AppTokens.primary,
        onPrimary: AppTokens.primaryForeground,
        secondary: AppTokens.secondary,
        onSecondary: AppTokens.secondaryForeground,
        surface: AppTokens.background,
        onSurface: AppTokens.backgroundForeground,
        error: AppTokens.destructive,
        onError: AppTokens.destructiveForeground,
        outline: AppTokens.border,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTokens.primary,
          foregroundColor: AppTokens.primaryForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacing4,
            vertical: AppTokens.spacing2,
          ),
          textStyle: const TextStyle(
            fontSize: AppTokens.fontSizeSm,
            fontWeight: AppTokens.fontWeightMedium,
          ),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTokens.fontFamilySans,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppTokens.primaryDark,
        onPrimary: AppTokens.primaryForegroundDark,
        secondary: AppTokens.secondaryDark,
        onSecondary: AppTokens.secondaryForegroundDark,
        surface: AppTokens.backgroundDark,
        onSurface: AppTokens.backgroundForegroundDark,
        error: AppTokens.destructiveDark,
        outline: AppTokens.borderDark,
      ),
    );
  }
}
