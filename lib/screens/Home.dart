import "package:flutter/material.dart";
import 'package:flutterapp2/widgets/layout.dart';
import "../widgets/drawer.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title:"Home Page",
      body: Center(child: Text("Main")),
      drawer: MyDrawer(),
    );
  }
}
