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
      title: 'Nick\'s Calculator', // Title of the app
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
        // Clear functionality
        input = '';
        result = '0';
      } else if (value == '=') {
        // Evaluate expression
        try {
          final expression = Expression.parse(input);
          final evaluator = const ExpressionEvaluator();
          var evalResult = evaluator.eval(expression, {});

          // Handle division by zero
          if (evalResult.toString() == 'Infinity' || evalResult.toString() == '-Infinity') {
            result = 'Error'; // Show Error for division by zero
          } else {
            result = evalResult.toString();
          }
        } catch (e) {
          result = 'Error'; // Handle invalid expression
        }
      } else {
        input += value; // Append the input
      }
    });
  }

  Widget buildButton(String value, {Color? color}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color ?? Colors.grey[300],
        ),
        onPressed: () => _onPressed(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Bold and more visible text
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Name\'s Calculator'), // Title on the calculator screen
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                '$input = $result', // Display the input expression and result
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
                  buildButton('/', color: Colors.lightBlueAccent), // Operation button
                ],
              ),
              Row(
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('*', color: Colors.lightBlueAccent), // Operation button
                ],
              ),
              Row(
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-', color: Colors.lightBlueAccent), // Operation button
                ],
              ),
              Row(
                children: [
                  buildButton('C', color: Colors.redAccent), // Clear button on the bottom left
                  buildButton('0'),
                  buildButton('=', color: Colors.lightBlueAccent), // Equals button on the bottom right
                  buildButton('+', color: Colors.lightBlueAccent), // Operation button
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
