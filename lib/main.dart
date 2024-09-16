import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nick\'s Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = ''; // Stores the user input expression
  String result = '0'; // Stores the result or current calculation

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(input);
          final evaluator = const ExpressionEvaluator();
          var evalResult = evaluator.eval(expression, {});
          if (evalResult.toString() == 'Infinity' || evalResult.toString() == '-Infinity') {
            result = 'Error'; // Handle division by zero
          } else {
            result = evalResult.toString();
          }
        } catch (e) {
          result = 'Error'; // Handle invalid expression
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String value, {Color? color}) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Rectangular shape
          ),
          side: const BorderSide(color: Colors.grey), // Outline/stroke color
          backgroundColor: color ?? Colors.white, // Background color of buttons
        ),
        onPressed: () => _onPressed(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nick\'s Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                '$input = $result',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          Column(
            children: [
              Row(
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                ],
              ),
              Row(
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                ],
              ),
              Row(
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                ],
              ),
              Row(
                children: [
                  buildButton('C', color: Colors.redAccent),
                  buildButton('0'),
                  buildButton('=', color: Colors.lightBlueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton('%', color: Colors.lightBlueAccent),
                  buildButton('/', color: Colors.lightBlueAccent),
                  buildButton('*', color: Colors.lightBlueAccent),
                  buildButton('-', color: Colors.lightBlueAccent),
                  buildButton('+', color: Colors.lightBlueAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
