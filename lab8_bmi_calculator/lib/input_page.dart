import 'package:flutter/material.dart';
import 'calculator_brain.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool isMale = true;
  int height = 176;
  int weight = 68;
  int age = 22;

  static const Color scaffoldBg = Color(0xFF080A15);
  static const Color cardBg = Color(0xFF121526);
  static const Color accentColor = Color(0xFFEB1555);
  static const Color glassBorder = Colors.white10;
  static const double cardRadius = 24.0;

  Widget _buildGenderCard(bool male) {
    final isSelected = isMale == male;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isMale = male),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: isSelected ? accentColor.withOpacity(0.1) : cardBg,
            borderRadius: BorderRadius.circular(cardRadius),
            border: Border.all(
              color: isSelected ? accentColor : glassBorder,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                male ? Icons.male_rounded : Icons.female_rounded,
                size: 48,
                color: isSelected ? accentColor : Colors.white38,
              ),
              const SizedBox(height: 8),
              Text(
                male ? 'NAM' : 'NỮ',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white38,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bộ đếm cho cân nặng & tuổi
  Widget _buildCounterCard(String label, int value, VoidCallback onMinus, VoidCallback onPlus) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: glassBorder),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 13, letterSpacing: 1.5),
            ),
            Text(
              '$value',
              style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoundBtn(Icons.remove, onMinus),
                const SizedBox(width: 20),
                _buildRoundBtn(Icons.add, onPlus),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundBtn(IconData icon, VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 45, height: 45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      fillColor: const Color(0xFF1C1F32),
      elevation: 0,
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: const Text('BMI ANALYSIS'),
        backgroundColor: scaffoldBg,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildGenderCard(true),
                const SizedBox(width: 16),
                _buildGenderCard(false),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(cardRadius),
                  border: Border.all(color: glassBorder),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('CHIỀU CAO', style: TextStyle(color: Colors.white38, letterSpacing: 2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('$height', style: const TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.w900)),
                        const Text(' cm', style: TextStyle(color: Colors.white38, fontSize: 18)),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                        activeTrackColor: accentColor,
                        thumbColor: Colors.white,
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 100, max: 220,
                        onChanged: (v) => setState(() => height = v.round()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                _buildCounterCard('CÂN NẶNG', weight,
                        () => setState(() => weight = (weight - 1).clamp(20, 200)),
                        () => setState(() => weight = (weight + 1).clamp(20, 200))),
                const SizedBox(width: 16),
                _buildCounterCard('TUỔI', age,
                        () => setState(() => age = (age - 1).clamp(1, 100)),
                        () => setState(() => age = (age + 1).clamp(1, 100))),
              ],
            ),
            const SizedBox(height: 32),

            GestureDetector(
              onTap: () {
                CalculatorBrain calc = CalculatorBrain(height, weight);
                Navigator.push(context, MaterialPageRoute(builder: (c) => ResultPage(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                )));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEB1555), Color(0xFFFF4D8D)],
                    begin: Alignment.centerLeft, end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: accentColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'PHÂN TÍCH CHỈ SỐ',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}