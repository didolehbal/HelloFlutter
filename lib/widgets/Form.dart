import "package:flutter/material.dart";
import 'package:flutterapp2/widgets/layout.dart';

class CustomForm extends StatelessWidget {
  CustomForm({this.value, this.onChanged, this.onSubmit, this.title});

  final String value;
  final Function onSubmit;
  final Function onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Enter ',
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: onSubmit,
                    child: Text('Submit'),
                  ),
                )),
          ],
        ));
  }
}
