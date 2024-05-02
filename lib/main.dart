import 'package:flutter/material.dart';

import 'QR_Code_Scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade900),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'QR Code Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[900],
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: QRCodeScan(),
          ),
        ],
      ),
     );
  }
}
