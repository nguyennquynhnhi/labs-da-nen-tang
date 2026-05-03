import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  const ResultPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  Color getResultColor() {
    switch (resultText.toLowerCase()) {
      case 'béo phì':
        return Colors.red;
      case 'thừa cân':
        return Colors.orange;
      case 'bình thường':
        return const Color(0xFF24D876);
      case 'thiếu cân':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {
    switch (resultText.toLowerCase()) {
      case 'béo phì':
        return Icons.error_outline;
      case 'thừa cân':
        return Icons.warning_amber_rounded;
      case 'bình thường':
        return Icons.check_circle_outline;
      case 'thiếu cân':
        return Icons.trending_down;
      default:
        return Icons.help_outline;
    }
  }

  double getBMIValue() {
    return double.tryParse(bmiResult) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final resultColor = getResultColor();
    final bmiValue = getBMIValue();

    const bgColor = Color(0xFF0A0E21);
    const cardColor = Color(0xFF1D1E33);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'KẾT QUẢ BMI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: bgColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card kết quả
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: resultColor.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Trạng thái Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(getStatusIcon(), color: resultColor, size: 28),
                            const SizedBox(width: 12),
                            Text(
                              resultText.toUpperCase(),
                              style: TextStyle(
                                color: resultColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),

                        // Chỉ số BMI
                        Column(
                          children: [
                            Text(
                              bmiValue.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 96,
                                fontWeight: FontWeight.w800,
                                height: 1.0,
                              ),
                            ),
                            const Text(
                              'BMI',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 4,
                              ),
                            ),
                          ],
                        ),

                        _BMIScaleIndicator(
                          currentBMI: bmiValue,
                          currentColor: resultColor,
                        ),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            interpretation,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEB1555),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'TÍNH LẠI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget thanh phân loại BMI
class _BMIScaleIndicator extends StatelessWidget {
  final double currentBMI;
  final Color currentColor;

  const _BMIScaleIndicator({
    required this.currentBMI,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Thiếu cân', Colors.blue, 18.5),
      ('Bình thường', const Color(0xFF24D876), 25.0),
      ('Thừa cân', Colors.orange, 30.0),
      ('Béo phì', Colors.red, 40.0),
    ];

    return Column(
      children: [
        // Thanh Gradient + Marker tính toán
        LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;
            final double clampedBMI = currentBMI.clamp(10.0, 40.0);
            final double percentage = (clampedBMI - 10.0) / 30.0;

            final double leftPosition = (percentage * maxWidth - 8).clamp(0.0, maxWidth - 16.0);

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                // Thanh gradient nền
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Color(0xFF24D876), Colors.orange, Colors.red],
                    ),
                  ),
                ),

                Positioned(
                  left: leftPosition,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: currentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        // Nhãn phân loại
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((cat) {
            final isCurrent = _isInRange(currentBMI, cat.$3, categories);
            return Text(
              cat.$1,
              style: TextStyle(
                color: isCurrent ? cat.$2 : Colors.white38,
                fontSize: 12,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _isInRange(double bmi, double max, List<(String, Color, double)> cats) {
    final index = cats.indexWhere((c) => c.$3 == max);
    final min = index == 0 ? 0.0 : cats[index - 1].$3;
    return bmi >= min && bmi < max;
  }
}