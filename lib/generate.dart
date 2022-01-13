import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:qrcode/Screen/sign_in.dart';
import 'package:qrcode/Utils/authentication.dart';
import 'package:qrcode/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  late User _user;
  String qrData = "PARA GENERAR CODIGO PULSE EL BOTON";
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    _user = widget._user;
    List<String> dominio = _user.email!.split('@');
    if (dominio[1] != "ittizimin.edu.mx") {
      Authentication.signOut(context: context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ),
      );
    } else {
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador QR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.login, color: Colors.white, size: 30.0),
              onPressed: () {
                _googleSignIn.signOut().then((value) {
                  setState(() {
                    Authentication.signOut(context: context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  });
                }).catchError((e) {
                  print(e);
                });
              }),
        ],
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              _user.photoURL!,
              height: 50,
              width: 50,
              alignment: Alignment.center,
            ),
            Text(
              _user.displayName!,
              textAlign: TextAlign.center,
            ),
            QrImage(
              data: qrData,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
              child: FlatButton(
                color: Colors.blue,
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  if (qrdataFeed.text.isEmpty) {
                    setState(() {
                      int timestamp = DateTime.now().millisecondsSinceEpoch;
                      String time = timestamp.toString();
                      List<String> matricula = _user.email!.split('@');
                      qrData = matricula[0] + "_IN_" + time;
                    });
                  } else {
                    setState(() {
                      qrData = "GENERE CODIGO";
                    });
                  }
                },
                child: Text(
                  "ENTRADA",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
              child: FlatButton(
                color: Colors.red,
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  if (qrData.isNotEmpty) {
                    //a little validation for the textfield
                    setState(() {
                      int timestamp = DateTime.now().millisecondsSinceEpoch;
                      String time = timestamp.toString();
                      List<String> matricula = _user.email!.split('@');
                      qrData = matricula[0] + "_OUT_" + time;
                    });
                  }
                },
                child: Text(
                  "SALIDA",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}
