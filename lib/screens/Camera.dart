import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import "../widgets//layout.dart";

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  VisionText visionTextOCR;
  Future<VisionText> textRecognoition(File imageFile) {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final Future<VisionText> visionText =
        textRecognizer.processImage(visionImage);
    return visionText;
  }

  Future<void> openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make a Choice'),
            actions: <Widget>[
              FlatButton(
                child: Text('Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  File croppedFile = await ImageCropper.cropImage(
                    sourcePath: file.path,
                  );
                  VisionText visionText = await textRecognoition(croppedFile);
                  
                  setState(() {
                    imageFile = file;
                    visionTextOCR = visionText;
                  });
                },
              ),
              FlatButton(
                child: Text('Camera'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 400,
                      maxHeight: 400);
                  File croppedFile =
                      await ImageCropper.cropImage(sourcePath: file.path);
                  VisionText visionText = await textRecognoition(croppedFile);
                  print(visionText.text);
                  setState(() {
                    imageFile = file;
                    visionTextOCR = visionText;
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Camera',
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    openDialog(context);
                  },
                  child: Text(
                    'Pick Image',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Text(
                  '${visionTextOCR == null ? '' : visionTextOCR.text}',
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.blueAccent, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (imageFile != null)
                              ? FileImage(
                                  imageFile,
                                )
                              : NetworkImage("https://i1.pngguru.com/preview/592/974/469/white-text-icon-set-trash-empty-empty-trash-text-overlay-png-clipart-thumbnail.jpg"))
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
