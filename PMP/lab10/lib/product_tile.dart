import 'package:flutter/material.dart';
import '../product_model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteToggle;

  ProductTile({required this.product, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xFFE8EBF6),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          product.name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'A delicious and healthy breakfast option.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        trailing: GestureDetector(
          onTap: onFavoriteToggle,
          child: Icon(
            Icons.favorite,
            color: product.isFavorite ? Colors.red : Colors.grey,
            size: 32,
          ),
        ),
      ),
    );
  }
}
