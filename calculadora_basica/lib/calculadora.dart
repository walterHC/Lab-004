import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String input = "";
  String result = "0";

  late List<String> items = [
    "AC",
    "C",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Calculadora Basica - Flutter'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              headerWidget(),
              Container(child: resultWidget()),
              Expanded(child: buttonWidget())
            ],
          )),
    );
  }

  Widget headerWidget() {
    return Container(
        color: Colors.grey.withOpacity(0.1),
        padding: const EdgeInsets.all(15),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),
            Text(
              "Calculadora",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.more_vert),
          ],
        ));
  }

  Widget resultWidget() {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            alignment: Alignment.centerRight,
            child: Text(
              input,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: TextStyle(
                fontSize: 42,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(66, 232, 232, 232),
      child: MasonryGridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          final height = index == 15 ? 190.0 : 90.0;
          return button(items[index], height);
        },
        itemCount: items.length,
      ),
    );
  }

  getColor(String item) {
    if (item == "÷" ||
        item == "x" ||
        item == "-" ||
        item == "+" ||
        item == "=" ||
        item == "AC" ||
        item == "C") {
      return Colors.white;
    }

    return Colors.indigo;
  }

  getBgColor(String item) {
    if (item == "AC" || item == "C") {
      return Colors.redAccent;
    }
    if (item == "=") {
      return const Color.fromARGB(255, 104, 204, 159);
    }

    if (item == "÷" || item == "x" || item == "-" || item == "+") {
      return Colors.blueAccent;
    }

    return Colors.white;
  }

  Widget button(String item, double height) {
    return InkWell(
      onTap: () {
        handleButtonPress(item);
      },
      child: Container(
          height: height,
          decoration: BoxDecoration(
              color: getBgColor(item),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1,
                )
              ]),
          child: Center(
            child: Text(item,
                style: TextStyle(
                    color: getColor(item),
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          )),
    );
  }

  handleButtonPress(String item) {
    if (item == "AC") {
      setState(() {
        input = "";
        result = "0";
      });
      return;
    }

    if (item == "C") {
      if (input.isNotEmpty) {
        setState(() {
          input = input.substring(0, input.length - 1);
        });
        return;
      } else {
        return null;
      }
    }

    if (item == "=") {
      if (!input.endsWith("=")) {
        result = calculate();
        if (result.endsWith(".0")) {
          setState(() {
            result = result.replaceAll(".0", "");
          });
        }
        setState(() {
          input += item;
        });
      }
      return;
    }

    if (!input.contains("=")) {
      setState(() {
        input += item;
      });
    }

    return;
  }

  String calculate() {
    try {
      var inputExpression = input
          .replaceAll("x", "*")
          .replaceAll("÷", "/")
          .replaceAll("%", "/100*");
      var expression = Parser().parse(inputExpression);
      var evaluation = expression.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
