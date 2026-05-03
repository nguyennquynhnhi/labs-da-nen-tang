import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0E21),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEB1555),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: const Color(0xFFEB1555),
          inactiveTrackColor: Colors.white24,
          thumbColor: const Color(0xFFEB1555),
          overlayColor: const Color(0xFFEB1555).withOpacity(0.15),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
          trackHeight: 4,
        ),
      ),
      home: const InputPage(),
    );
  }
}