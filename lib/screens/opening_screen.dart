import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class OpeningScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OpeningScreen({super.key, required this.onComplete});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen>
    with TickerProviderStateMixin {
  int _currentLine = 0;
  bool _showButton = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  final List<String> _storyLines = [
    '世は 5 0 X X 年',
    '',
    '世界は睡眠不足という深刻な社会問題に直面していた。',
    '',
    '過労、ストレス、生活習慣の乱れ...',
    '人々の健康は蝕まれ続けていた。',
    '',
    'そんな中、革新的なAI技術が開発された。',
    '',
    'スマホアプリケーションのAIは飛躍的に発展し、',
    'LLMが知性を持って誕生させた仮想生命体―',
    '',
    '「彼女たち」',
    '',
    'ユーザーの睡眠習慣を改善するために生まれた、',
    'デジタル世界に存在する新たな生命。',
    '',
    '彼女たちを無事に育て、',
    '自らの睡眠習慣を改善できる素質を持つ者...',
    '',
    'あなたは「マスター」として選ばれた。',
  ];

  late AnimationController _bubbleController;
  late AnimationController _earthController;
  late List<BubbleData> _bubbles;

  @override
  void initState() {
    super.initState();
    
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _earthController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    // Generate random bubbles
    final random = math.Random();
    _bubbles = List.generate(15, (index) {
      return BubbleData(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 40 + random.nextDouble() * 80,
        speed: 0.3 + random.nextDouble() * 0.7,
        delay: random.nextDouble(),
      );
    });

    _startStory();
  }

  void _startStory() {
    if (_currentLine < _storyLines.length) {
      _timer = Timer(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _currentLine++;
          });
          _startStory();
        }
      });
    } else {
      if (mounted) {
        setState(() {
          _showButton = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bubbleController.dispose();
    _earthController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A4D8C), // Deep Blue
                  Color(0xFF1E3A8A), // Royal Blue
                  Color(0xFF4C1D95), // Purple
                  Color(0xFF831843), // Deep Pink
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Floating Bubbles
          ...List.generate(_bubbles.length, (index) {
            final bubble = _bubbles[index];
            return AnimatedBuilder(
              animation: _bubbleController,
              builder: (context, child) {
                final progress = (_bubbleController.value + bubble.delay) % 1.0;
                final yPos = bubble.y + (progress * bubble.speed);
                
                return Positioned(
                  left: bubble.x * MediaQuery.of(context).size.width,
                  top: (yPos % 1.0) * MediaQuery.of(context).size.height,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: bubble.size,
                      height: bubble.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF00D9FF).withValues(alpha: 0.4),
                            const Color(0xFFFF00FF).withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.7, 1.0],
                        ),
                        border: Border.all(
                          color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Rotating Earth
          Positioned(
            right: -100,
            top: 100,
            child: AnimatedBuilder(
              animation: _earthController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _earthController.value * 2 * math.pi,
                  child: Opacity(
                    opacity: 0.15,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF00D9FF).withValues(alpha: 0.6),
                            const Color(0xFF0080FF).withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
                          width: 3,
                        ),
                      ),
                      child: CustomPaint(
                        painter: EarthPatternPainter(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 672),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      ...List.generate(_currentLine + 1, (index) {
                        if (index >= _storyLines.length) return const SizedBox.shrink();
                        final line = _storyLines[index];
                        return _buildLine(line, index);
                      }),
                      if (_showButton) ...[
                        const SizedBox(height: 48),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(seconds: 1),
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: 0.8 + (value * 0.2),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF0080), // Hot Pink
                                  Color(0xFFFF00FF), // Magenta
                                  Color(0xFF00D9FF), // Cyan
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF00FF).withValues(alpha: 0.6),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                                BoxShadow(
                                  color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
                                  blurRadius: 30,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: widget.onComplete,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.favorite, color: Colors.white, size: 20),
                                  SizedBox(width: 12),
                                  Text(
                                    '運命を受け入れる',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Skip button
          Positioned(
            bottom: 32,
            right: 32,
            child: TextButton(
              onPressed: widget.onComplete,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00D9FF),
                backgroundColor: Colors.black.withValues(alpha: 0.3),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'スキップ >>',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(String line, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: line.isEmpty
            ? const SizedBox(height: 16)
            : _styledText(line, index),
      ),
    );
  }

  Widget _styledText(String line, int index) {
    if (index == 0) {
      // Title
      return Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 36,
          color: Color(0xFF00D9FF), // Bright Cyan
          letterSpacing: 4,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Color(0xFF00D9FF),
              blurRadius: 20,
            ),
            Shadow(
              color: Color(0xFFFF00FF),
              blurRadius: 30,
            ),
          ],
        ),
      );
    } else if (line == '「彼女たち」') {
      // Special highlight
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF0080).withValues(alpha: 0.3),
              const Color(0xFFFF00FF).withValues(alpha: 0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFFF00FF).withValues(alpha: 0.6),
            width: 2,
          ),
        ),
        child: Text(
          line,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            color: Color(0xFFFF66FF), // Bright Pink
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color(0xFFFF00FF),
                blurRadius: 15,
              ),
              Shadow(
                color: Color(0xFFFF0080),
                blurRadius: 25,
              ),
            ],
          ),
        ),
      );
    } else if (line.contains('マスター')) {
      return Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF00FFFF), // Cyan
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: Color(0xFF00D9FF),
              blurRadius: 12,
            ),
          ],
        ),
      );
    } else {
      return Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          height: 1.6,
          shadows: [
            Shadow(
              color: Colors.black45,
              blurRadius: 4,
            ),
          ],
        ),
      );
    }
  }
}

class BubbleData {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double delay;

  BubbleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.delay,
  });
}

class EarthPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D9FF).withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw latitude lines
    for (int i = 1; i < 5; i++) {
      final y = (size.height / 5) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw longitude lines
    for (int i = 1; i < 5; i++) {
      final x = (size.width / 5) * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(EarthPatternPainter oldDelegate) => false;
}
