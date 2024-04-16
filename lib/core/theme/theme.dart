import 'package:flutter/material.dart';

class AppTheme {
  static _border([color = Colors.teal]) => OutlineInputBorder(
          borderSide: BorderSide(
        color: color,
        width: 3,
      ));
  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: false,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      errorBorder: _border(Colors.red),
      focusedErrorBorder: _border(Colors.red),
      focusedBorder: _border(Colors.green),
    ),
  );
}
