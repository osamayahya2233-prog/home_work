import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleGridApp());
}

class SimpleGridApp extends StatelessWidget {
  const SimpleGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLetterBox('A'),
                    const SizedBox(width: 30),
                    _buildLetterBox('B'),
                    const SizedBox(width: 30),
                    _buildLetterBox('C'),
                  ],
                ),
              ),
              
              // Fancy Section
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Fancy Section',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              
              // Number Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0,
                    
                    children: [
                      _buildNumberBox('1'),
                      _buildNumberBox('2'),
                      _buildNumberBox('3'),
                      _buildNumberBox('4'),
                      _buildNumberBox('5'),
                      _buildNumberBox('6'),
                    ],
                  ),
                ),
              ),
              
              // Info Cards Label
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Text(
                  'Info Cards',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              
              // Info Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('23', 'Active'),
                    _buildInfoBox('15', 'Pending'),
                    _buildInfoBox('7', 'Completed'),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterBox(String letter) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 133, 146, 157),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(163, 252, 218, 0),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberBox(String number) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 158, 64),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 162, 150, 150),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(221, 255, 255, 255),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(202, 242, 148, 7),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(202, 242, 148, 7),
            ),
          ),
        ],
      ),
    );
  }
}
