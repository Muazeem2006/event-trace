import 'package:event_trace/models/User.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final LocalStorage tokenStorage = LocalStorage('token');
  final LocalStorage userStorage = LocalStorage('user');
  String? token;
  User? user;
  @override
  Widget build(BuildContext context) {
    var tokenData = tokenStorage.getItem('token');
    if (tokenData != null) {
      token = tokenData.toString();
    }
    var userData = userStorage.getItem('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.lightBlue[800]!,
              ),
            ),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
                Text(
                  user?.role.toString() ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
                Text(
                  token.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
