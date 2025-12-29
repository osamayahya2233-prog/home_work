import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = '';
  String result = '0';

  void onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '=') {
        try {
          result = calculate(input);
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  String formatResult(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  String calculate(String expression) {
    List<String> operators = ['+', '-', '×', '÷'];

    for (var op in operators) {
      if (expression.contains(op)) {
        var parts = expression.split(op);
        double num1 = double.parse(parts[0]);
        double num2 = double.parse(parts[1]);

        double calcResult;

        switch (op) {
          case '+':
            calcResult = num1 + num2;
            break;
          case '-':
            calcResult = num1 - num2;
            break;
          case '×':
            calcResult = num1 * num2;
            break;
          case '÷':
            calcResult = num1 / num2;
            break;
          default:
            calcResult = 0;
        }

        return formatResult(calcResult);
      }
    }
    return expression;
  }

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              input,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('÷', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('×', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('C', color: Colors.red),
                    buildButton('0'),
                    buildButton('=', color: Colors.green),
                    buildButton('+', color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
