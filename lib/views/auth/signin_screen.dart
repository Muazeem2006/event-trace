// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/models/User.dart';
import 'package:event_trace/services/request.dart';
import 'package:event_trace/views/start_screen.dart';
import 'package:event_trace/views/utils/custom_input.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:event_trace/views/utils/social_button.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key, required this.role}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
  final String role;
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalStorage userStorage = LocalStorage('user');
  final LocalStorage tokenStorage = LocalStorage('token');
  bool isObscure = true;
  bool isSwitched = false;

  List socialPaths = [
    {"text": "Login with Google", "path": "assets/images/google-icon.png"},
    {"text": "Login with Facebook", 'path': "assets/images/facebook-icon.png"},
  ];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginUser() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String role = widget.role;

    if (email.isEmpty || password.isEmpty) {
      triggerToast(context, "Please enter email and password", Colors.red,
          Theme.of(context).colorScheme.inversePrimary);
    }

    // TODO: Add logic to login user
    final user = User(email: email, password: password, role: role);

    loginUser(user, context);
  }

  Future<void> loginUser(User user, BuildContext context) async {
    try {
      // Show a loading indicator while saving a user
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      //request to the server
      FormData formData = FormData.fromMap(user.toMap());

      final response = await postRequest('login', formData);
      if (response.data['user'] != null) {
        final user = User.fromMap(response.data['user']);
        final token = response.data['token'];

        tokenStorage.setItem('token', token);
        userStorage.setItem('user', user.toJson());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StartScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(
                'The provided credentials are not valid. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Saving Failed'),
            content: Text(
                'An error occurred while saving the user. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle network or server error
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'An error occurred. Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/logo-02.png"),
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "EVENT TRACE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Sign In".padRight(8) +
                        (widget.role == "admin"
                            ? " as Admin"
                            : widget.role == "event_organizer"
                                ? "as Event Organizer"
                                : widget.role == "venue_owner"
                                    ? "as Venue Owner"
                                    : "as Attendee"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
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
                      } else if (value.length <= 5) {
                        return "Password should contain at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        value: isSwitched,
                        onChanged: (bool value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        title: Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/verify");
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: DynamicButton(
                      buttonText: "Signin",
                      onTap: () async {
                        _loginUser();
                        // if (_formKey.currentState!.validate()) {
                        //   Navigator.pushNamed(context, "/start");
                        // }
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
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
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          "Sign up",
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
