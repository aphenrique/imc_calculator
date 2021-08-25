import 'package:flutter/material.dart';

class ImcCalculatorPage extends StatefulWidget {
  const ImcCalculatorPage({Key? key}) : super(key: key);

  @override
  _ImcCalculatorPageState createState() => _ImcCalculatorPageState();
}

class _ImcCalculatorPageState extends State<ImcCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcule seu IMC'),
      ),
      body: Container(),
    );
  }
}
