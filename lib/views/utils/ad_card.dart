// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 130,
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff00F8FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/ad.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invite your friends",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Get \$20 for ticket",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 36, 193, 198),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "INVITE",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
