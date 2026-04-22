import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1C0A00),
        appBar: AppBar(
          title: const Text(
            '💰 I Am Rich',
            style: TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          backgroundColor: const Color(0xFF1C0A00),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF120600),
                Color(0xFF401A01),
                Color(0xFF8E440A),
                Color(0xFFE28A35),
                Color(0xFFFFB771),
                Color(0xFFE28A35),
                Color(0xFF8E440A),
                Color(0xFF401A01),
                Color(0xFF120600)
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'I AM RICH',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'images/rich.png',
                  width: 380,
                  height: 380,
                ),
                const SizedBox(height: 30),
                const Text(
                  '✦  Luxury  ✦  Wealth  ✦  Power  ✦',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 13,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}