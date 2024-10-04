import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                          child: Image.asset(
                              'assets/four_dots_white.png', // Путь к изображению
                          ),
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
        CategoryIcon(icon: FontAwesomeIcons.heartPulse),
        CategoryIcon(icon: FontAwesomeIcons.stethoscope, isStethoscope: true), // Специальная обработка стетоскопа
        CategoryIcon(icon: FontAwesomeIcons.tooth),
        CategoryIcon(icon: FontAwesomeIcons.dna),
      ],
    );
  }
}

// Иконка для каждой категории
class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final bool isStethoscope; // Новый параметр для специальной обработки стетоскопа

  CategoryIcon({required this.icon, this.isStethoscope = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: !isStethoscope ? Colors.white : Colors.orange, // Белый фон
        borderRadius: BorderRadius.circular(18), // Закругленные углы
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Цвет тени
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 4), // Смещение тени
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: 30,
          color: isStethoscope ? Colors.white : Colors.blue, // Белая иконка для стетоскопа
        ),
      ),
      padding: EdgeInsets.all(8), // Внутренний отступ
    );
  }
}


// Список врачей
// Список врачей
class DoctorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DoctorCard(
            name: "Dr. Jaison",
            specialty: "Pulmonologist",
            rating: 5.0,
            time: "10:00 AM - 3:00 PM",
            avatar: "assets/doctor1_avatar.png"
        ),
        DoctorCard(
            name: "Dr. Wilson",
            specialty: "General Pulmonologist",
            rating: 4.5,
            time: "10:00 AM - 2:00 PM",
            avatar: "assets/doctor2_avatar.png"
        ),
        DoctorCard(
            name: "Dr. Adams",
            specialty: "Pulmonologist",
            rating: 4.5,
            time: "11:00 AM - 4:00 PM",
            avatar: "assets/doctor3_avatar.png"
        ),
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
  final String avatar; // Новый параметр для изображения аватара

  DoctorCard({required this.name, required this.specialty, required this.rating, required this.time, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white, // Белый фон
        borderRadius: BorderRadius.circular(12), // Закругленные углы
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Цвет тени
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 4), // Смещение тени вниз
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Используем изображение вместо иконки
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage(avatar),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(specialty),
                // Рейтинг и время в одной строке
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16), // Иконка звезды
                    SizedBox(width: 4),
                    Text(rating.toString()), // Рейтинг
                    SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey), // Иконка часов
                        SizedBox(width: 4),
                        Text(time), // Время
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
