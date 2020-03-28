import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  Layout({this.title,this.body,this.drawer, this.floatingActionButton, this.floatingActionButtonLocation});
  final String title;
  final Widget body;
  final Widget drawer;
  final floatingActionButton;
  final floatingActionButtonLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.blueGrey,),
      body:body,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation:floatingActionButtonLocation
    );
  }
}