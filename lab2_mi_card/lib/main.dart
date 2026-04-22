import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Dùng Container bọc toàn bộ body để tạo LinearGradient
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF6B6B), // Đỏ san hô (Coral Red) - đậm và sâu
                Color(0xFFFF8E53), // Cam đào (Peach Orange)
                Color(0xFFFFC371), // Vàng cam (Pastel Yellow-Orange) - sáng ở góc dưới
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/avt.jpg'),
                ),
                const SizedBox(height: 16),

                // Tên
                const Text(
                  'Nguyễn Nhã Quỳnh Nhi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                // Chức danh
                Text(
                  'Student',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9), // Trắng hơi trong suốt để dịu mắt
                    fontSize: 16,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),
                Divider(
                    color: Colors.white.withOpacity(0.5), // Đường kẻ mờ hòa vào nền
                    thickness: 1,
                    indent: 70,
                    endIndent: 70
                ),
                const SizedBox(height: 24),

                // Số điện thoại (Hiệu ứng Glassmorphism)
                Card(
                  color: Colors.white.withOpacity(0.2), // Nền trong suốt 20%
                  elevation: 0, // Bỏ bóng đổ để giao diện phẳng và mượt hơn
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1), // Thêm viền sáng mờ
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: const ListTile(
                    leading: Icon(Icons.phone, color: Colors.white),
                    title: Text(
                      '+84 812 455 169',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // Email
                Card(
                  color: Colors.white.withOpacity(0.2),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: const ListTile(
                    leading: Icon(Icons.email, color: Colors.white),
                    title: Text(
                      'nhinnq.23ite@vku.udn.vn',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5, // Email dài nên giảm spacing một chút
                      ),
                    ),
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