// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white, // Background color
    primary: Color(0xff3d56f0), // Define your blue shade
    primaryContainer: Color(0xff46cdfb), // Define your cyan shade
    secondary: Colors.grey.shade500, // Grey as part of the color scheme
    secondaryContainer:
        Colors.grey.shade400, // Lighter shade of grey for containers
    tertiary:
        Colors.grey.shade800, // Another shade of grey for tertiary elements
    tertiaryContainer: Colors
        .grey[300], // Lighter shade of grey for tertiary elements in containers
    inversePrimary:
        Colors.white, // Text color that contrasts with primary color
    error: Colors.red, // Error color
    onPrimary: Colors.black, // Text color for elements on primary color
    onPrimaryContainer:
        Colors.black, // Text color for elements on primary color containers
    onSecondary: Colors.black, // Text color for elements on secondary color
    onSecondaryContainer:
        Colors.black, // Text color for elements on secondary color containers
    onBackground: Colors.black, // Text color for elements on background color
    onTertiary: Colors.black, // Text color for elements on tertiary color
    onError: Colors.white, // Text color for error messages
  ),
);
