// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:event_trace/views/utils/custom_input.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:event_trace/views/utils/social_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isConfirmedObscure = true;

  List socialPaths = [
    {"text": "Login with Google", "path": "assets/images/google-icon.png"},
    {"text": "Login with Facebook", 'path': "assets/images/facebook-icon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: BackButton(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                          "Sign Up".padRight(8) +
                    (widget.role == "admin" ? " as Admin" :
                    widget.role == "event_organizer" ? "as Event Organizer" :
                    widget.role == "venue_owner" ? "as Venue Owner" :
                    "as Attendee"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomInput(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    hintText: "Full name",
                    labelText: "Full name",
                    prefixIcon: Icon(Icons.person_4_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomInput(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.mail_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains("@")) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomInput(
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                    ),
                    obscureText: isObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomInput(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmedObscure = !isConfirmedObscure;
                        });
                      },
                      icon: Icon(isConfirmedObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                    ),
                    obscureText: isConfirmedObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: DynamicButton(
                    buttonText: 'Sign in',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushReplacementNamed(context, '/start');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    socialPaths.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: SocialButton(
                        buttonText: socialPaths[index]["text"],
                        iconPath: socialPaths[index]['path'],
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          "Signin",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
