// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, unused_element, implementation_imports, unnecessary_import, prefer_final_fields, unused_field, avoid_print

import 'package:flutter/src/material/raised_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    //Tirar banner de debug
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  //stful
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controllers para recerber os valores nos campos
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      // corrige o erro de não sumir as mensagem de validadção
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc <= 18.5) {
        _infoText = "Abaixo do PesoIMC:${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Peso normal IMC:${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc <= 29.9) {
        _infoText = "Sobrepeso IMC:${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc <= 34.9) {
        _infoText = "Obesidade 1 IMC:${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc <= 39.9) {
        _infoText = "Obesidade 2 IMC:${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40) {
        _infoText = "Obesidade 3 IMC:${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso(KG)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura(CM)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    }, //chamando a função no botão
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
