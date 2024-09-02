// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:event_trace/views/auth/signin_screen.dart';
import 'package:event_trace/views/auth/signup_screen.dart';
import 'package:event_trace/views/utils/dynamic_dropdown_button.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.35,
            ),
            Text(
              'Welcome to Event Trace',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Text(
                'Create an account with us and experience seamless event planning',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DynamicDropdownButton(
                items: [
                  DropdownMenuItem(
                    value: 'event_organizer',
                    child: Text('Event Organizer'),
                  ),
                  DropdownMenuItem(
                    value: 'venue_owner',
                    child: Text('Venue Owner'),
                  ),
                  DropdownMenuItem(
                    value: 'attendee',
                    child: Text('Attendee'),
                  ),
                  DropdownMenuItem(
                    value: 'admin',
                    child: Text('Admin'),
                  ),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SigninScreen(
                          role: value,
                        ),
                      ),
                    );
                  }
                },
                buttonText: ('Signin').toUpperCase(),
                buttonTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect( 
              borderRadius: BorderRadius.circular(10),
              child: DynamicDropdownButton(
                items: [
                  DropdownMenuItem(
                    value: 'event_organizer',
                    child: Text('Event Organizer'),
                  ),
                  DropdownMenuItem(
                    value: 'venue_owner',
                    child: Text('Venue Owner'),
                  ),
                  DropdownMenuItem(
                    value: 'attendee',
                    child: Text('Attendee'),
                  ),
                  DropdownMenuItem(
                    value: 'admin',
                    child: Text('Admin'),
                  ),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(
                          role: value,
                        ),
                      ),
                    );
                  }
                },
                buttonText: ('Sign Up').toUpperCase(),
                buttonTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
