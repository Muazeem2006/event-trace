// ignore_for_file: prefer_const_constructors

import 'package:event_trace/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 70,
      child: Stack(
        children: [
          Positioned(
            left: 40,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
                image: DecorationImage(
                  image: AssetImage("assets/images/member-03.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: appPurple,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
                image: DecorationImage(
                  image: AssetImage("assets/images/member-02.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: appGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
              image: DecorationImage(
                image: AssetImage("assets/images/member-01.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

