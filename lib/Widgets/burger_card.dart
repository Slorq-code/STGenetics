import 'package:flutter/material.dart';

class BurgerCard extends StatelessWidget {
  final String name;
  final double price;
  final String category;

  const BurgerCard({super.key, required this.name, required this.price, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
