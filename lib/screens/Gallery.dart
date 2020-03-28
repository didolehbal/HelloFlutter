import 'package:flutter/material.dart';
import 'package:flutterapp2/widgets/layout.dart';
import "../widgets/Form.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

fetchPicturesAsync(keyword) {
  String url =
      "https://pixabay.com/api/?key=5832566-81dc7429a63c86e3b707d0429&q=$keyword";
  return http.get(url);
}

class _GalleryScreenState extends State<GalleryScreen> {
  String keyword;
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "Gallery",
      value: keyword,
      onChanged: (value) {
        setState(() {
          keyword = value;
        });
      },
      onSubmit: () {
        if (!keyword.isEmpty) {
          fetchPicturesAsync(keyword).then((resp) {
            var data = json.decode(resp.body);
            print(data["hits"]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GalleryList(keyword, data["hits"])));
          }).catchError((err) {
            print("no data for $keyword , $err");
          });
        }
      },
    );
  }
}

class GalleryList extends StatelessWidget {
  GalleryList(this.keyword, this.data);

  List<dynamic> data;
  final keyword;
  @override
  Widget build(BuildContext context) {
    return Layout(
        title: "Gallery of keyword $keyword",
        body: ListView(
          children: <Widget>[...data.map((gal) => GalleryCard(gal))],
        ));
  }
}

class GalleryCard extends StatelessWidget {
  GalleryCard(this.gal);
  dynamic gal;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(image: NetworkImage(gal["largeImageURL"])),
        ],
      ),
    );
  }
}
