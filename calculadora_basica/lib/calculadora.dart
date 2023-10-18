import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String input = "";
  String resultado = "0";

  void agregar(String texto) {
    setState(() {
      input += texto;
    });
  }

  void calcular() {
    // calcular el resultado de la operación
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
      ),
      body: Column(
        children: [
          TextField(
            controller: TextEditingController(text: input),
            readOnly: true,
            decoration: InputDecoration(border: OutlineInputBorder()),
            textAlign: TextAlign.right,
          ),
          TextField(
            controller: TextEditingController(text: resultado),
            readOnly: true,
            decoration: InputDecoration(border: OutlineInputBorder()),
            textAlign: TextAlign.right,
          ),
          Row(
            children: [
              ElevatedButton(onPressed: () => agregar("1"), child: Text("1")),
              ElevatedButton(onPressed: () => agregar("2"), child: Text("2")),
              ElevatedButton(onPressed: () => agregar("3"), child: Text("3")),
              ElevatedButton(onPressed: () => agregar("+"), child: Text("+")),
            ],
          ),
          ElevatedButton(onPressed: calcular, child: Text("=")),
        ],
      ),
    );
  }
}
