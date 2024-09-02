import 'package:flutter/material.dart';

/// A splash screen widget that displays a background image and a logo.
class SplashScreen extends StatelessWidget {
  /// Constructor for SplashScreen widget.
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
