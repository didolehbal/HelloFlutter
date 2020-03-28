import "package:flutter/material.dart";
import 'package:flutterapp2/screens/Camera.dart';
import 'package:flutterapp2/screens/QrCode.dart';
import "../screens/Quiz.dart";
import '../screens/Weather.dart';
import '../screens/Gallery.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Center(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.supervised_user_circle,
                size: 96,
                color: Colors.lightBlue,
              ),
            ),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blueGrey, Colors.white])),
          ),
          ListTile(
              title: Text("Quiz"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => Quiz()));
              }),
          ListTile(
            title: Text("Weather"),
            trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => WeatherScreen()));
              }
          ),
          ListTile(
            title: Text("Gallery"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => GalleryScreen()));
              }
          ),
          ListTile(
            title: Text("QrCode"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => QRCodeScreen()));
              }
          ),   ListTile(
            title: Text("Camera"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => CameraScreen()));
              }
          ),
        ],
      ),
    ));
  }
}
