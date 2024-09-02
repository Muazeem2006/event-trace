import 'package:flutter/material.dart';

class OutlineDynamicButton extends StatelessWidget {
  const OutlineDynamicButton({
    super.key,
    required this.buttonText,
    required this.action,
  });

  final String buttonText;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: action,
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(
          270,
          50,
        ),
      ),
      child: Text(
        buttonText.toUpperCase(),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
