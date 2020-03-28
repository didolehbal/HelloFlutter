import "package:flutter/material.dart";

import "screens/Home.dart";

void main(List<String> args) {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
