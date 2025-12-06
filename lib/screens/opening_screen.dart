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

  late AnimationController _gridController;

  @override
  void initState() {
    super.initState();
    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _startStory();
  }

  void _startStory() {
    if (_currentLine < _storyLines.length) {
      _timer = Timer(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _currentLine++;
          });
          // Auto scroll to bottom if needed, though the design seems to fit in one screen mostly?
          // If it gets long, we might want to scroll.
          // Let's just let it build up.
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
    _gridController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated background grid
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateX(60 * math.pi / 180),
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: _gridController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: GridPainter(offset: _gridController.value),
                      size: Size.infinite,
                    );
                  },
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 672), // max-w-2xl
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40), // Top spacing
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
                            return Opacity(
                              opacity: value,
                              child: child,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF00CC), Color(0xFFD500F9)], // Brighter Pink to Vivid Purple
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF00FF).withValues(alpha: 0.8),
                                  blurRadius: 30,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: widget.onComplete,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '運命を受け入れる',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.chevron_right, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40), // Bottom spacing
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
                foregroundColor: Colors.grey[600],
              ),
              child: const Text('スキップ >>'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(String line, int index) {
    // Animation for each line
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: line.isEmpty
            ? const SizedBox(height: 16)
            : _styledText(line, index),
      ),
    );
  }

  Widget _styledText(String line, int index) {
    if (index == 0) {
      // Glitch text effect approximation
      return Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 32, // md:text-5xl approx
          color: Color(0xFFFF40FF), // Brighter Pink
          letterSpacing: 3.2, // 0.1em
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Color(0xFFFF00FF),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
            Shadow(
              color: Color(0xFF00FFFF), // Cyan glitch
              blurRadius: 10,
              offset: Offset(-2, 0),
            ),
            Shadow(
              color: Color(0xFFFF0080), // Red-Pink glitch
              blurRadius: 10,
              offset: Offset(2, 0),
            ),
          ],
        ),
      );
    } else if (line == '「彼女たち」') {
      return Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24, // md:text-3xl
          color: Color(0xFFFF66FF), // Brighter Pink
          shadows: [
            Shadow(
              color: Color(0xFFFF00FF),
              blurRadius: 20,
            ),
            Shadow(
              color: Color(0xFFFF00FF),
              blurRadius: 40,
            ),
          ],
        ),
      );
    } else if (line.contains('マスター')) {
      return Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20, // md:text-2xl
          color: Color(0xFF00FFFF),
          shadows: [
            Shadow(
              color: Color(0xFF00FFFF),
              blurRadius: 8,
            ),
          ],
        ),
      );
    } else {
      return Text(
        line,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16, // md:text-lg
          color: Colors.grey[300],
        ),
      );
    }
  }
}

class GridPainter extends CustomPainter {
  final double offset;

  GridPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF00FF).withValues(alpha: 0.8) // Brighter grid
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2) // Glow effect
      ..style = PaintingStyle.stroke;

    const gridSize = 50.0;
    
    // We need to draw a grid that covers the screen plus some extra for the perspective transform
    // Since we are transforming the parent, the canvas size here is effectively infinite or whatever the parent allows.
    // But for performance, we should limit it.
    // However, since we use Size.infinite in CustomPaint, we need to pick a reasonable area to draw.
    // Let's draw enough to cover the view.
    
    // Actually, because of the perspective transform, the "top" of the grid is far away and small.
    // We should draw a large area centered on the screen.
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Draw vertical lines
    // We want them to be static horizontally relative to the grid, but the grid itself is static?
    // The React code says: background-image ... linear-gradient(90deg, ...)
    // And animation moves it.
    // Wait, the React animation is `gridMove` which translates Z.
    // In CSS 3D, translating Z moves the plane towards the camera.
    // In our case, we can simulate movement by shifting the horizontal lines (which represent depth) downwards.
    
    // Vertical lines (converging to vanishing point in perspective, but parallel in 2D before transform)
    for (double x = -1000; x <= 1000; x += gridSize) {
      canvas.drawLine(
        Offset(centerX + x, -1000),
        Offset(centerX + x, 1000),
        paint,
      );
    }

    // Horizontal lines (moving towards viewer)
    // The offset goes from 0 to 1.
    // We shift all horizontal lines by offset * gridSize.
    final shift = offset * gridSize;
    
    for (double y = -1000; y <= 1000; y += gridSize) {
      final dy = y + shift;
      canvas.drawLine(
        Offset(-1000, centerY + dy),
        Offset(1000, centerY + dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) => oldDelegate.offset != offset;
}
