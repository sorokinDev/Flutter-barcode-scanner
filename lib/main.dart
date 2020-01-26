import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final barCodes = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildContent(),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: buildButton(),
          )
        ],
      ),
    );
  }

  Widget buildContent() {
    if(barCodes.isEmpty) {
      return Center(
        child: Text('Вы еще ничего не сканировали!'),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20),
      itemCount: barCodes.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Text(
            'Barcode №${index}: ${barCodes[index]}',
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(height: 20.0,),
    );
  }

  Widget buildButton() {
    return CupertinoButton.filled(
        child: Text('Scan!'),
        onPressed: () async {
          String scanRes = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.BARCODE,
          );
          if(scanRes != null && scanRes.isNotEmpty) {
            setState(() {
              barCodes.add(scanRes);
            });
          }
        }
    );
  }

}