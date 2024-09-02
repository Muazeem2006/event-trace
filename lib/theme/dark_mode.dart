// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Color(0xff3d56f0), // Define your deep blue shade
    primaryContainer: Color(0xff46cdfb), // Define your cyan shade
    secondary: Colors.grey.shade500, // Grey as part of the color scheme
    secondaryContainer:
        Colors.grey[400], // Lighter shade of grey for containers
    background: Color(0xff1f2c34), // Background color for dark mode
    tertiary: Colors.grey[800], // Another shade of grey for tertiary elements
    tertiaryContainer: Colors
        .grey[300], // Lighter shade of grey for tertiary elements in containers
    inversePrimary:
        Color.fromARGB(255, 230, 230, 230), // Text color that contrasts with primary color
    error: Colors.red, // Error color
    onPrimary: Colors.white, // Text color for elements on primary color
    onPrimaryContainer:
        Colors.white, // Text color for elements on primary color containers
    onSecondary: Colors.white, // Text color for elements on secondary color
    onSecondaryContainer:
        Colors.white, // Text color for elements on secondary color containers
    onBackground: Colors.white, // Text color for elements on background color
    onTertiary: Colors.white, // Text color for elements on tertiary color
    onError: Colors.black, // Text color for error messages
  ),
);
