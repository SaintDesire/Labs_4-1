import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Blue Salad',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/salad.jpg', // Путь к изображению из assets
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.timer, color: Colors.orange),
                            SizedBox(height: 4),
                            Text(
                              '32 mins',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.people, color: Colors.orange),
                            SizedBox(height: 4),
                            Text(
                              '2 people',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.local_fire_department, color: Colors.orange),
                            SizedBox(height: 4),
                            Text(
                              '23 calories',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Directions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. Melt 2 tablespoons butter in a large skillet over medium-high heat. Add shrimp, salt, and pepper to taste. Cook, stirring occasionally, until pink, about 2-3 minutes; set aside.\n\n'
                    '2. Add garlic to the skillet, and cook, stirring frequently, until fragrant, about 1 minute. Stir in chicken stock and lemon juice. Bring to a boil; reduce heat and simmer...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Foods'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Wine'),
        ],
      ),
    );
  }
}
