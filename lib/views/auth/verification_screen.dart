// ignore_for_file: prefer_const_constructors

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/views/utils/custom_input.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:event_trace/views/auth/verification_code_screen.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController phoneController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verification",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                       SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            "Enter your phone number for verification code",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomInput(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    hintText: "Phone number",
                    labelText: "Phone number",
                    prefixIcon: Icon(Icons.call),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: DynamicButton(
                    buttonText: "Continue",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationCodeScreen(),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/reset");
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "Use Email address instead",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: auxBlack,
                    ),
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
