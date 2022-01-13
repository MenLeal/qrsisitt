import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StatefulDialog extends StatefulWidget {
  @override
  _StatefulDialogState createState() => _StatefulDialogState();
}

class _StatefulDialogState extends State<StatefulDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty
                              ? null
                              : "Matricula No Válida";
                        },
                        decoration:
                            InputDecoration(hintText: "Introducir matricula"),
                      ),
                      TextFormField(
                        controller: _textEditingController2,
                        decoration:
                            InputDecoration(hintText: "Ingrese contraseña"),
                      ),
                    ],
                  )),
              title: Text('Iniciar Sesión'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK'),
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: _textEditingController2.text,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () async {
                await showInformationDialog(context);
              },
              child: Text(
                "Stateful Dialog",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),
      ),
    );
  }
}
