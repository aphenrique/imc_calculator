import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImcCalculatorPage extends StatefulWidget {
  const ImcCalculatorPage({Key? key}) : super(key: key);

  @override
  _ImcCalculatorPageState createState() => _ImcCalculatorPageState();
}

class _ImcCalculatorPageState extends State<ImcCalculatorPage> {
  //
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _focusNode = FocusNode();

  String _imcInfo = 'Informe seus dados';

  void _resetTextFields() {
    _heightController.text = '';
    _weightController.text = '';
    _focusNode.requestFocus();

    setState(() {
      _imcInfo = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double _weight = double.parse(_weightController.text);
      double _height = double.parse(_heightController.text) / 100;
      double _result = _weight / (_height * _height);

      if (_result < 18.5) {
        _imcInfo = 'Abaixo do peso (${_result.toStringAsFixed(2)})';
      } else if (_result >= 18.5 && _result < 24.9) {
        _imcInfo = 'Peso ideal (${_result.toStringAsFixed(2)})';
      } else if (_result >= 24.9 && _result < 29.9) {
        _imcInfo = 'Sobrepeso (${_result.toStringAsFixed(2)})';
      } else if (_result >= 29.9) {
        _imcInfo = 'Obeso (${_result.toStringAsFixed(2)})';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcule seu IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetTextFields,
            icon: Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.blueGrey,
              ),
              TextFormField(
                controller: _weightController,
                autofocus: true,
                focusNode: _focusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira o peso!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  suffixStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: _heightController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira a altura!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  suffixStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    elevation: MaterialStateProperty.all(8.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculate();
                    }
                  },
                  child: Text(
                    'Calcular',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _imcInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
