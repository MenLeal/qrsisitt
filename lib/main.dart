import 'package:flutter/material.dart';
import 'package:qrcode/Screen/sign_in.dart';
import 'package:qrcode/generate.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var login = preferences.getBool('login');
  runApp(MaterialApp(
    title: 'qrsisitt',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: login == false ? GeneratePage() : SignInScreen(),
  ));
}
