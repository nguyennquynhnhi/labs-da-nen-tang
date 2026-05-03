import 'package:flutter/material.dart';
import 'story_brain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  late AnimationController _storyController;
  late Animation<double> _storyFade;
  late Animation<Offset> _storySlide;
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _storyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _storyFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _storyController, curve: Curves.easeOut),
    );
    _storySlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _storyController, curve: Curves.easeOutCubic),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _buttonScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.elasticOut),
    );

    _storyController.forward();
    _buttonController.forward();
  }

  void choose(int choice) {
    setState(() {
      _storyController.reset();
      _buttonController.reset();
      storyBrain.makeChoice(choice);
      _storyController.forward();
      _buttonController.forward();
    });
  }

  void restart() {
    setState(() {
      _storyController.reset();
      _buttonController.reset();
      storyBrain.reset();
      _storyController.forward();
      _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _storyController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFinished = storyBrain.isFinished();
    final int storyIndex = storyBrain.getStoryIndex();

    // Màu gradient theo từng câu chuyện
    List<Color> getGradientColors() {
      if (isFinished) {
        if (storyIndex == 3) return [const Color(0xFF1B5E20), const Color(0xFF0D3320)]; // Vàng - xanh lá
        if (storyIndex == 4) return [const Color(0xFF1565C0), const Color(0xFF0A2C5E)]; // Làng - xanh dương
        if (storyIndex == 5) return [const Color(0xFF6A1B9A), const Color(0xFF2D0B3E)]; // Gấu - tím
        return [const Color(0xFF424242), const Color(0xFF1A1A1A)]; // Bình thường - xám
      }
      return [const Color(0xFF1B1B2F), const Color(0xFF0D0D1A)]; // Mặc định
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: getGradientColors(),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Progress indicator
                if (!isFinished) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (storyIndex + 1) / 3,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.tealAccent.withOpacity(0.8),
                      ),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Story content card
                Expanded(
                  flex: 6,
                  child: FadeTransition(
                    opacity: _storyFade,
                    child: SlideTransition(
                      position: _storySlide,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon/Emoji animation
                            if (isFinished)
                              TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: Text(
                                      storyIndex == 3 ? '💰' :
                                      storyIndex == 4 ? '🏡' :
                                      storyIndex == 5 ? '🐻' : '🤔',
                                      style: const TextStyle(fontSize: 64),
                                    ),
                                  );
                                },
                              ),
                            if (isFinished) const SizedBox(height: 20),

                            Text(
                              storyBrain.getStory(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: isFinished ? 22 : 20,
                                height: 1.7,
                                fontWeight: isFinished ? FontWeight.w600 : FontWeight.w400,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons area
                ScaleTransition(
                  scale: _buttonScale,
                  child: Column(
                    children: [
                      if (isFinished) ...[
                        // Restart button with glow effect
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: restart,
                            icon: const Icon(Icons.replay_rounded, size: 24),
                            label: const Text(
                              'Chơi lại',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ] else ...[
                        // Choice 1 button
                        _buildChoiceButton(
                          text: storyBrain.getChoice1(),
                          onPressed: () => choose(1),
                          gradientColors: [Colors.teal[400]!, Colors.teal[700]!],
                          icon: Icons.arrow_forward_rounded,
                        ),
                        const SizedBox(height: 14),
                        // Choice 2 button
                        _buildChoiceButton(
                          text: storyBrain.getChoice2(),
                          onPressed: () => choose(2),
                          gradientColors: [Colors.deepPurple[400]!, Colors.deepPurple[700]!],
                          icon: Icons.arrow_forward_rounded,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceButton({
    required String text,
    required VoidCallback onPressed,
    required List<Color> gradientColors,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white.withOpacity(0.8),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}