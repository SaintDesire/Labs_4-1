import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab4_5/func_page.dart';
import 'package:lab4_5/main.dart';

import 'doctor_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IpAddressScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20.0),
              width: 60,
              height: 60,
              child: Image.asset(
                'assets/four_dots_black.png',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FuncScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20.0),
              width: 60,
              height: 60,
              child: Image.asset(
                'assets/four_dots_black.png',
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEEF1FF), // Цвет верхней части экрана
                      Colors.white, // Переход к белому
                    ],
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80), // Большой отступ сверху для всех элементов начиная с "Hello, Jessica!"
                  Row(
                    children: [
                      Text(
                        "Hello, \nSergey!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 15), // Отступ между текстом и иконкой
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0), // Отступ сверху для иконки
                        child: Icon(FontAwesomeIcons.capsules, size: 30, color: Colors.red), // Иконка после текста
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  SearchBar(),
                  SizedBox(height: 16),
                  StayHomeBanner(),
                  SizedBox(height: 16),
                  Text("What do you need?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ServicesGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Виджет для поиска с обновленными стилями
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.grey[400]), // Светло-серый цвет текста
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.grey[400]), // Светло-серый цвет текста в hint
        prefixIcon: Icon(Icons.search, color: Colors.grey[400]), // Иконка светло-серая
        border: InputBorder.none, // Убираем border
        filled: true,
        fillColor: Colors.grey[200], // Фоновый цвет
      ),
    );
  }
}

// Виджет для баннера Stay Home
class StayHomeBanner extends StatefulWidget {
  @override
  _StayHomeBannerState createState() => _StayHomeBannerState();
}

class _StayHomeBannerState extends State<StayHomeBanner> {
  bool _isVisible = true; // Переменная для контроля видимости баннера

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF6A67CE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Stay home! ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text:
                        "\nSchedule an e-visit and discuss the plan with a doctor.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/mask_girl.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 2,
          top: -15,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = false; // Скрываем баннер при нажатии
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 22),
              padding: EdgeInsets.all(4),
            ),
          ),
        ),
      ],
    )
        : SizedBox.shrink(); // Возвращаем пустой виджет, когда баннер скрыт
  }
}

// Сетка кнопок
class ServicesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3, // 3 кнопки в одной строке
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ServiceButton(icon: FontAwesomeIcons.stethoscope, label: "Diagnostic", isHighlighted: true),
        ServiceButton(icon: FontAwesomeIcons.syringe, label: "Shots", isHighlighted: false),
        ServiceButton(icon: FontAwesomeIcons.phone, label: "Consultation", isHighlighted: false),
        ServiceButton(icon: FontAwesomeIcons.ambulance, label: "Ambulance", isHighlighted: false),
        ServiceButton(icon: FontAwesomeIcons.userNurse, label: "Nurse", isHighlighted: true),
        ServiceButton(icon: FontAwesomeIcons.vial, label: "Lab Work", isHighlighted: false),
      ],
    );
  }
}

// Виджет для кнопок
class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isHighlighted;

  ServiceButton({required this.icon, required this.label, required this.isHighlighted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorPage(data: 'Pressed ' + label + ' button'),
          ),
        );
      },
      child: Card(
        color: isHighlighted ? Colors.orange : Colors.white, // Оранжевый для выделенных кнопок
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: isHighlighted ? Colors.white : Colors.blue),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isHighlighted ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
