import 'package:flutter/material.dart';

bool isANumber(String s) {
  if (s.isEmpty) return false;

  final number = num.tryParse(s);

  return (number == null) ? false : true;

}

void showAlertDialog( BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Oops!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}