import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade200,
    secondary: Colors.white,
    inversePrimary: Colors.grey.shade700,
    background: Colors.grey.shade300,
    onPrimary: Colors.grey.shade800,
    onSecondary: Colors.grey.shade800,
  ),
  // Add the custom dialog theme
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey.shade300, // Background color of the dialog
    titleTextStyle: TextStyle(
      color: Colors.grey.shade800,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ), // Text color of the title
    contentTextStyle: TextStyle(
      color: Colors.grey.shade800,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ), // Text color of the content
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(8.0), // Adjust the border radius as needed
    ),
  ),
  // Add the button theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.grey.shade900,
      backgroundColor: Colors.grey.shade500, // Button background color
    ),
  ),
);
