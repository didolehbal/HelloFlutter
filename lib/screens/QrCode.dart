import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/widgets/layout.dart';

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCodeScreen> {
  String result;
  Future scanQR() async {
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unkown error";
        });
      }
    } on FormatException catch (e) {
      result = "You pressed de back button befor scanning";
    } catch (e) {
      setState(() {
        result = "Other error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'QR Code Scan',
      body: Center(
        child: Text(
          result != null ? result : 'Scan RQ',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.scanner), onPressed: scanQR, label: Text('QR Scan'), backgroundColor: Colors.blueGrey,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
