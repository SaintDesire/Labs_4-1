import 'package:flutter/material.dart';

import 'home_page.dart';

class DoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Верхний блок с фоновым цветом
          Container(
            color: Color(0xFF6A67CE), // Фон верхней части экрана
            height: 300, // Высота верхнего блока
          ),
          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Выровнять стрелку и меню по сторонам
                    children: [
                      // Стрелка назад с отступами
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white, // Белый фон
                            borderRadius: BorderRadius.circular(10), // Закругленные углы
                          ),
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      // Кнопка меню с 4 точками
                      GestureDetector(
                        onTap: () {
                          // Логика для открытия меню
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.more_vert, color: Colors.white), // Иконка меню с точками
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Заголовок "Top doctors" с большим отступом сверху
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Top doctors",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.yellow), // Желтая звезда
                  ],
                ),
              ),
              SizedBox(height: 40), // Отступ между заголовком и блоком с категориями
              // Блок с белым фоном и закругленным только левым верхним углом
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Белый фон для блока категорий и ниже
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24), // Закругленный верхний левый угол
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Добавляем текст "Categories" и "See all"
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey, // Серый цвет для See all
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16), // Отступ перед кнопками категорий
                      Categories(), // Кнопки категорий
                      SizedBox(height: 16),
                      Expanded(child: DoctorList()), // Список врачей
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Кнопки категорий
class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryIcon(icon: Icons.favorite, label: "Cardiology"),
        CategoryIcon(icon: Icons.health_and_safety, label: "Pulmonology"),
        CategoryIcon(icon: Icons.medical_services, label: "Dentistry"),
      ],
    );
  }
}

// Иконка для каждой категории
class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.orange),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

// Список врачей
class DoctorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DoctorCard(name: "Dr. Jaison", specialty: "Pulmonologist", rating: 5.0, time: "10:00 AM - 3:00 PM"),
        DoctorCard(name: "Dr. Wilson", specialty: "General Pulmonologist", rating: 4.5, time: "10:00 AM - 2:00 PM"),
        DoctorCard(name: "Dr. Adams", specialty: "Pulmonologist", rating: 4.5, time: "11:00 AM - 4:00 PM"),
      ],
    );
  }
}

// Карточка врача
class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final String time;

  DoctorCard({required this.name, required this.specialty, required this.rating, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.person, size: 40, color: Colors.blue),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(specialty),
                Text(time),
              ],
            ),
            Spacer(),
            Icon(Icons.star, color: Colors.yellow),
            Text(rating.toString()),
          ],
        ),
      ),
    );
  }
}
