import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Clean UI
      home: DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDice = 1;
  int rightDice = 1;

  void rollDice() {
    setState(() {
      leftDice = Random().nextInt(6) + 1;
      rightDice = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Quan trọng: Cho phép body tràn lên dưới AppBar
      appBar: AppBar(
        title: const Text(
          '🎲 Dicee',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.transparent, // Làm trong suốt AppBar
        centerTitle: true,
        elevation: 0, // Xóa bóng đổ của AppBar
      ),
      // Bọc body bằng Container để tạo Linear Gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF434343), // Xám than (Charcoal Gray) ở trên
              Color(0xFF000000), // Đen tuyền (Pure Black) ở dưới
            ],
          ),
        ),
        child: SafeArea(
          // Dùng SafeArea để UI không đè lên tai thỏ/status bar của điện thoại
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Khu vực hiển thị 2 xúc xắc
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset('images/dice$leftDice.png'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset('images/dice$rightDice.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // Nút lắc (Button)
                ElevatedButton(
                  onPressed: rollDice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2C2C2C), // Chữ màu xám đen đậm
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    elevation: 8, // Tăng bóng đổ để nút nổi bật trên nền đen
                    shadowColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Bo góc mềm mại hơn
                    ),
                  ),
                  child: const Text('ROLL DICE'), // Chuyển thành ALL CAPS cho mạnh mẽ
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}