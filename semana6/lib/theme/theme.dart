import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// El [AppTheme] define los temas claro y oscuro para la app.
sealed class AppTheme {
  // Tema claro
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.deepPurple,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      appBarBackgroundSchemeColor: SchemeColor.primary, // Fondo AppBar: color primario del tema
      appBarCenterTitle: true, // Centra los títulos de las AppBars
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // Tema oscuro
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.deepPurple,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      appBarBackgroundSchemeColor: SchemeColor.primary, // Fondo AppBar: color primario del tema
      appBarCenterTitle: true, // Centra los títulos de las AppBars
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}