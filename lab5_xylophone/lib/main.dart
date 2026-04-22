import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  XylophonePage({super.key});

  void playSound(int noteNumber) {
    player.play(AssetSource('sounds/note$noteNumber.wav'));
  }

  Widget buildKey({required Color color, required int noteNumber}) {
    return Expanded(
      child: TextButton(
        onPressed: () => playSound(noteNumber),
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎵 Xylophone',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(color: Colors.red,        noteNumber: 1),
            buildKey(color: Colors.orange,     noteNumber: 2),
            buildKey(color: Colors.yellow,     noteNumber: 3),
            buildKey(color: Colors.green,      noteNumber: 4),
            buildKey(color: Colors.teal,       noteNumber: 5),
            buildKey(color: Colors.blue,       noteNumber: 6),
            buildKey(color: Colors.purple,     noteNumber: 7),
          ],
        ),
      ),
    );
  }
}