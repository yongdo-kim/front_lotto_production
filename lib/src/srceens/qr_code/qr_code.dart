import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeView extends StatefulWidget {
  @override
  _QrCodeViewState createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  @override
  Widget build(BuildContext context) {
    ScanController controller = ScanController();

    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width, // custom wrap size
              height: MediaQuery.of(context).size.height,
              child: ScanView(
                controller: controller,
                scanAreaScale: .7,
                scanLineColor: Colors.green.shade400,
                onCapture: (data) async {
                  await launchURL(data);
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () => Get.back()))
          ],
        ));
  }

  Future launchURL(String qrUrl) async {
    String url = qrUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}