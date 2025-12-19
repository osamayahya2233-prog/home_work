import 'package:flutter/material.dart';

class ProductBox extends StatelessWidget {
  final String name;
  final String image;
  
  const ProductBox({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Row(
          children: [
            Image.asset(
              image, // صححت من "name" إلى image
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}