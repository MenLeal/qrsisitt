import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qrcode/Screen/sign_in.dart';
import 'package:qrcode/generate.dart';

class LoggedIn extends StatefulWidget {
  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  User? userAuth;
  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      userAuth = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userAuth == null) {
      return SignInScreen();
    } else {
      return GeneratePage(user: userAuth!);
    }
  }
}
