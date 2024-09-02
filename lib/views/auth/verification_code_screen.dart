// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:event_trace/views/utils/custom_input.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController codeController = TextEditingController();
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
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        child: SizedBox(
                          width: 230,
                          child: Text(
                            "We've send you the verification code on +234 814 323 6834",
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
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    hintText: "4 Digit Code",
                    labelText: "4 Digit Code",
                    prefixIcon: Icon(Icons.hive_outlined),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: DynamicButton(
                    buttonText: "Continue",
                    onTap: () {
                      Navigator.pushNamed(context, "/reset");
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Re-send code in ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "0:20",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
