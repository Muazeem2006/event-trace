// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/views/auth/signup_screen.dart';
import 'package:event_trace/views/auth/signin_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List onboardingContent = [
    {
      'title': 'Explore Upcoming and Nearby Events',
      'description':
          'Event Trace is a simple and easy to use app that helps you to track your events.',
      'image': 'assets/images/onboarding-01.png',
    },
    {
      'title': 'Web Have Modern Event Calendar Feature',
      'description':
          'Event Trace helps you to track your events. You can track your events in real-time or offline.',
      'image': 'assets/images/onboarding-02.png',
    },
    {
      'title': 'To look up more events or activities nearby by map',
      'description':
          'Event Trace helps you to track your events. You can track your events in real-time or offline.',
      'image': 'assets/images/onboarding-03.png',
    },
  ];

  var roleOption = [
    'Attendee',
    'Event Organizer',
    'Venue Owner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingContent.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .6,
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 50),
                color: Theme.of(context).colorScheme.background,
                child: Image.asset(onboardingContent[index]['image']!),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(86, 104, 255, 1),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(48)),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .4,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: 240,
                                child: Column(
                                  children: [
                                    Text(
                                      onboardingContent[index]['title']!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Airbnb Cereal App",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                      ),
                                      child: Text(
                                        onboardingContent[index]
                                            ['description']!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Airbnb Cereal App",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 95.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // Navigate to login page when "Skip" is pressed
                                    triggerAuth(context);
                                  },
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      fontFamily: "Airbnb Cereal App",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    onboardingContent.length,
                                    (i) => Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: i == index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .inversePrimary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Change to the next page when "Next" is pressed
                                    if (index < onboardingContent.length - 1) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      // Navigate to the login page when on the last page
                                      // Navigator.pushReplacementNamed(
                                      //   context,
                                      //   '/intro',
                                      // );
                                      triggerAuth(context);
                                    }
                                  },
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                      fontFamily: "Airbnb Cereal App",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> triggerAuth(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      'Welcome to EVENT TRACE!',
                      style: TextStyle(
                        fontFamily: "Airbnb Cereal App",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Let\'s get started by creating an account. It\'s easy and only takes a minute.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Airbnb Cereal App",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomDropdown(
                      decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.black38),
                        closedBorderRadius: BorderRadius.circular(30),
                        closedFillColor: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: 'Signup Options',
                      items: roleOption,
                      onChanged: (value) {
                        if (value != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(
                                role: roleSlug(value),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontFamily: "Bebas",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Signing in is easy and we won\'t take long',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Airbnb Cereal App",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomDropdown(
                      decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.black38),
                        closedBorderRadius: BorderRadius.circular(30),
                        closedFillColor: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: 'Signin Options',
                      items: [
                        'Admin',
                        'Attendee',
                        'Event Organizer',
                        'Venue Owner',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SigninScreen(
                                role: roleSlug(value),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Thank you for choosing Event Trace',
                      style: TextStyle(
                        fontFamily: "Airbnb Cereal App",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
