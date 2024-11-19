import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final isFavorite = productProvider.isFavorite(product.id);

    return Scaffold(
      backgroundColor: Color(0xFFF8F8FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F8FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: product.imageUrl != null
                  ? Image.network(
                product.imageUrl!,
                height: 200,
                width: 150,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/default_image.png',
                height: 200,
                width: 150,
                fit: BoxFit.fill,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                productProvider.toggleFavorite(product.id);
              },
              child: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 32,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Directions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  for (var step in product.directions)
                    _buildStep(step),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String step) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            step,
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}