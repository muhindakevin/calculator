import 'package:flutter/material.dart';

void main() {
  runApp(SimpleCalculator());
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  // Define state variables for the calculator
  String displayText = "0";
  double firstNumber = 0;
  double secondNumber = 0;
  String operator = "";
  bool isFirstNumber = true;

  // Function to handle button press
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear the calculator
        displayText = "0";
        firstNumber = 0;
        secondNumber = 0;
        operator = "";
        isFirstNumber = true;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        // Store the operator and prepare for the second number
        operator = buttonText;
        isFirstNumber = false;
        displayText = "$firstNumber $operator ";
      } else if (buttonText == "=") {
        // Perform the calculation
        switch (operator) {
          case "+":
            displayText = (firstNumber + secondNumber).toString();
            break;
          case "-":
            displayText = (firstNumber - secondNumber).toString();
            break;
          case "*":
            displayText = (firstNumber * secondNumber).toString();
            break;
          case "/":
            if (secondNumber != 0) {
              displayText = (firstNumber / secondNumber).toString();
            } else {
              displayText = "Error";
            }
            break;
          default:
            displayText = "0";
        }
        isFirstNumber = true;
      } else {
        // Handle number input
        if (isFirstNumber) {
          if (displayText == "0") displayText = "";
          displayText += buttonText;
          firstNumber = double.parse(displayText);
        } else {
          displayText += buttonText;
          secondNumber = double.parse(buttonText);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Simple Calculator")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ],
            ),
            Row(
              children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*")
              ],
            ),
            Row(
              children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ],
            ),
            Row(
              children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+")
              ],
            ),
            Row(
              children: [
                buildButton("C"),
                buildButton("="),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24),
        ),
        onPressed: () => onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
