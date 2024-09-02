import 'package:flutter/material.dart';

class NoResultFound extends StatelessWidget {
  const NoResultFound({
    super.key, required this.errorText,
  });
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/no-data.png',
              height: 120,
            ),
            Text(
              errorText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
  }
}
