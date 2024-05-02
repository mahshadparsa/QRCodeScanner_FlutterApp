
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScan extends StatefulWidget {

  const QRCodeScan({super.key,});

  @override
  State<QRCodeScan> createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;
  bool qRCodeValidity=false;

  // In order to get hot reload to work we need to pause the camera if the platform

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void reassemble() {
    super.reassemble();
    //   if (Platform.isAndroid) {
    controller!.pauseCamera();
    //   } else if (Platform.isIOS) {
    //     controller!.resumeCamera();
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (!qRCodeValidity)?CustomPaint(
          painter: BorderPainter(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)),
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height:5,
                      color: Colors.amber[800],),
                  )
                ],
              ),
            ),
          ),
        ):
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                border: Border.all(width: 3, color: Colors.teal.shade100)),
            child: Icon(Icons.check_circle,size:120,color: Colors.teal[100],)),
        SizedBox(height: 20,),
        Center(
            child: (qRCodeValidity) ?
            Text('Barcode Type: ${result!.format}   Data: ${result!.code}',style: TextStyle(color: Colors.teal),):
            Text('Scan Barcode',style: TextStyle(color: Colors.teal),)
        ),
      ],
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 3.0;
    final radius = 20.0;
    final tRadius = 2 * radius;
    final rect = Rect.fromLTWH(width, width, size.width - 2 * width, size.height - 2 * width,);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final clippingRect0 = Rect.fromLTWH(0, 0, tRadius, tRadius,);
    final clippingRect1 = Rect.fromLTWH(size.width - tRadius, 0, tRadius, tRadius,);
    final clippingRect2 = Rect.fromLTWH(0, size.height - tRadius, tRadius, tRadius,);
    final clippingRect3 = Rect.fromLTWH(size.width - tRadius, size.height - tRadius, tRadius, tRadius,);

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.amber[800]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}