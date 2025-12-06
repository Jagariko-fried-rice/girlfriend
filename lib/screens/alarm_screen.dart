import 'dart:math';
import 'package:flutter/material.dart';
import 'girlfriend_setup_screen.dart';

class StorySegment {
  final int age;
  final String title;
  final String description;
  final String imageEmoji;

  StorySegment({
    required this.age,
    required this.title,
    required this.description,
    required this.imageEmoji,
  });
}

class HeartData {
  final int id;
  final double size;
  final double left;
  final double delay;
  final double duration;

  HeartData({
    required this.id,
    required this.size,
    required this.left,
    required this.delay,
    required this.duration,
  });
}

class FloatingHeart extends StatefulWidget {
  final HeartData data;

  const FloatingHeart({super.key, required this.data});

  @override
  State<FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<FloatingHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: (widget.data.duration * 1000).toInt()),
      vsync: this,
    );
    Future.delayed(
      Duration(milliseconds: (widget.data.delay * 1000).toInt()),
      () {
        if (mounted) {
          _controller.repeat();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 16.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;
        final height = MediaQuery.of(context).size.height;
        final bottom = -50 + (height + 100) * value;
        final shift = sin(value * 2 * pi) * 20;
        final opacity = (0.4 + value.abs() * 0.4 * (1 - value)).clamp(0.3, 0.5);
        final left =
            ((screenWidth - widget.data.size - horizontalPadding * 2) *
                (widget.data.left / 100)) +
            horizontalPadding +
            shift;

        return Positioned(
          bottom: bottom,
          left: left,
          child: Opacity(
            opacity: opacity,
            child: Text('💗', style: TextStyle(fontSize: widget.data.size)),
          ),
        );
      },
    );
  }
}

class AlarmScreen extends StatefulWidget {
  final GirlfriendConfig girlfriendConfig;
  final Map<String, String> sleepData;
  final VoidCallback onBack;

  const AlarmScreen({
    super.key,
    required this.girlfriendConfig,
    required this.sleepData,
    required this.onBack,
  });

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with TickerProviderStateMixin {
  final Map<String, Color> hairColorMap = {
    'pink': const Color(0xFFFF69B4),
    'blue': const Color(0xFF4169E1),
    'purple': const Color(0xFF9370DB),
    'silver': const Color(0xFFC0C0C0),
    'red': const Color(0xFFDC143C),
    'blonde': const Color(0xFFFFD700),
  };

  late final int _sleepQuality;
  late final List<StorySegment> _story;
  late final List<HeartData> _floatingHearts;
  bool _showStory = false;
  int _currentStoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _sleepQuality = _calculateSleepQuality();
    _story = _generateStory();
    _floatingHearts = List.generate(
      15,
      (index) => HeartData(
        id: index,
        size: Random().nextDouble() * 20 + 10,
        left: Random().nextDouble() * 100,
        delay: Random().nextDouble() * 5,
        duration: Random().nextDouble() * 5 + 8,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  TimeOfDay? _parseTime(String value) {
    try {
      final pieces = value.split(':');
      return TimeOfDay(
        hour: int.parse(pieces[0]),
        minute: int.parse(pieces[1]),
      );
    } catch (e) {
      return null;
    }
  }

  DateTime _asDate(String time) {
    final parsed = _parseTime(time);
    if (parsed == null) {
      return DateTime(2000, 1, 1, 23, 0);
    }
    return DateTime(2000, 1, 1, parsed.hour, parsed.minute);
  }

  int _calculateSleepQuality() {
    final bedtime = widget.sleepData['bedtime'];
    final wakeTime = widget.sleepData['wakeTime'];
    if (bedtime == null || wakeTime == null) {
      return 50;
    }
    final bed = _asDate(bedtime);
    var wake = _asDate(wakeTime);
    if (wake.isBefore(bed)) {
      wake = wake.add(const Duration(days: 1));
    }
    final hours = wake.difference(bed).inMinutes / 60;
    if (hours >= 7 && hours <= 8) return 95;
    if (hours >= 6 && hours <= 9) return 80;
    if (hours >= 5 && hours <= 10) return 65;
    return 50;
  }

  List<StorySegment> _generateStory() {
    final quality = _sleepQuality;
    final name = widget.girlfriendConfig.name;

    if (quality >= 80) {
      return [
        StorySegment(
          age: 0,
          title: '誕生',
          description: 'デジタル世界に$nameが生まれた。彼女の瞳には、まだ見ぬ世界への期待が輝いている。',
          imageEmoji: '👶',
        ),
        StorySegment(
          age: 5,
          title: '初めての学び',
          description: '$nameは好奇心旺盛な子供に成長した。毎日新しいことを学ぶのが楽しくて仕方ない。',
          imageEmoji: '📚',
        ),
        StorySegment(
          age: 10,
          title: '友達との思い出',
          description: '学校で沢山の友達ができた。放課後は皆で遊ぶのが日課になった。',
          imageEmoji: '🎨',
        ),
        StorySegment(
          age: 15,
          title: '夢を見つける',
          description: '$nameは自分の夢を見つけた。その夢に向かって、一歩ずつ進んでいく決意をした。',
          imageEmoji: '⭐',
        ),
        StorySegment(
          age: 18,
          title: 'マスターとの出会い',
          description: 'そして今、彼女はあなたのパートナーとして目覚めた。これからの人生を共に歩んでいく。',
          imageEmoji: '💖',
        ),
      ];
    }

    if (quality >= 60) {
      return [
        StorySegment(
          age: 0,
          title: '誕生',
          description: '$nameがデジタル世界に生まれた。まだ不安定だが、確かな存在として。',
          imageEmoji: '👶',
        ),
        StorySegment(
          age: 10,
          title: '成長の途中',
          description: '順調とは言えないが、それなりに成長している。',
          imageEmoji: '🌱',
        ),
        StorySegment(
          age: 18,
          title: '現在',
          description: 'まだ完全ではないが、あなたのパートナーとして目覚めた。',
          imageEmoji: '💫',
        ),
      ];
    }

    return [
      StorySegment(
        age: 0,
        title: '不完全な誕生',
        description: '$nameの生成は不完全だった。もっと睡眠時間が必要だ。',
        imageEmoji: '🌑',
      ),
      StorySegment(
        age: 18,
        title: '現在',
        description: '彼女はまだ完全に目覚めていない。次はもっと良い睡眠を。',
        imageEmoji: '😴',
      ),
    ];
  }

  Color _resolveHairColor() {
    return hairColorMap[widget.girlfriendConfig.hairColor] ?? Colors.pink;
  }

  Widget _buildMorningView() {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: const Color(0xFFFFF0F5))),
        IgnorePointer(
          child: Stack(
            children:
                _floatingHearts
                    .map((heart) => FloatingHeart(data: heart))
                    .toList(),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  children: [
                    _buildMorningCard(),
                    const SizedBox(height: 24),
                    _buildCloudRow(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMorningCard() {
    final hairColor = _resolveHairColor();
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFE4E9), Color(0xFFFFF0F5), Color(0xFFFFFFFF)],
        ),
        border: Border.all(color: const Color(0xFFFFB6C1), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.25),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AspectRatio(
                aspectRatio: 9 / 12,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFF0F5), Color(0xFFE6F5FF)],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.landscape, size: 48, color: Colors.white70),
                        SizedBox(height: 8),
                        Text(
                          '新しい景色を準備中…',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -70,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [hairColor, Colors.pink.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white, width: 5),
                      boxShadow: [
                        BoxShadow(
                          color: hairColor.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Text('👤', style: TextStyle(fontSize: 60)),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.auto_awesome,
                            color: Colors.white.withOpacity(0.8),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  'おはよう！',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    foreground:
                        Paint()
                          ..shader = const LinearGradient(
                            colors: [Color(0xFFFF69B4), Color(0xFFFF1493)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 0)),
                    shadows: [
                      Shadow(
                        color: Colors.pink.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  '${widget.girlfriendConfig.name}があなたを起こしに来たよ',
                  style: const TextStyle(
                    color: Color(0xFFB91C1C),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildVoiceBubble(),
                const SizedBox(height: 20),
                _buildSleepQualityIndicator(),
                const SizedBox(height: 20),
                _buildStoryButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceBubble() {
    final message =
        _sleepQuality >= 80
            ? 'おはよう！よく眠れたみたいだね💕 今日も一緒に頑張ろうね！'
            : _sleepQuality >= 60
            ? 'おはよう...もう少し寝た方が良かったんじゃない？💤'
            : 'おはよう...全然寝てないじゃない😢 心配だよ...';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB6C1), Color(0xFFFFC0CB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFFF69B4), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.favorite, size: 18, color: Color(0xFFB91C1C)),
              SizedBox(width: 6),
              Text(
                'モーニングメッセージ',
                style: TextStyle(fontSize: 12, color: Color(0xFF991B1B)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSleepQualityIndicator() {
    final trackColor = Colors.white;
    final progressColor =
        _sleepQuality >= 80
            ? const LinearGradient(
              colors: [Color(0xFFFF69B4), Color(0xFFFF1493)],
            )
            : _sleepQuality >= 60
            ? const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
            )
            : const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8787)],
            );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFFB6C1)),
      ),
      child: Column(
        children: [
          const Text(
            '睡眠の質',
            style: TextStyle(color: Color(0xFFB91C1C), fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: trackColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth * (_sleepQuality / 100),
                        decoration: BoxDecoration(
                          gradient: progressColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              _sleepQuality >= 80
                                  ? [
                                    BoxShadow(
                                      color: Colors.pink.withOpacity(0.4),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                  : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$_sleepQuality%',
                style: const TextStyle(
                  color: Color(0xFFB91C1C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() => _showStory = true);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          side: const BorderSide(color: Color(0xFFFF69B4)),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF69B4), Color(0xFFFF1493)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.book, size: 20),
                SizedBox(width: 8),
                Text('人生の軌跡を見る', style: TextStyle(fontSize: 16)),
                SizedBox(width: 6),
                Icon(Icons.auto_awesome, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloudRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cloud, color: Colors.pink.shade300, size: 40),
        const SizedBox(width: 12),
        Icon(Icons.cloud, color: Colors.pink.shade200, size: 50),
        const SizedBox(width: 12),
        Icon(Icons.cloud, color: Colors.pink.shade300, size: 35),
      ],
    );
  }

  Widget _buildStoryView() {
    final hairColorGradient =
        hairColorMap[widget.girlfriendConfig.hairColor] ?? Colors.pink;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE4F0), Color(0xFFEDE7FF), Color(0xFFCFE4FF)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${widget.girlfriendConfig.name}の人生',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB91C1C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Sleep Dive Memory Log',
                          style: TextStyle(color: Color(0xFFB91C1C)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children:
                        _story
                            .asMap()
                            .entries
                            .map(
                              (entry) => _buildStorySegment(
                                entry.key,
                                entry.value,
                                hairColorGradient,
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 24),
                  _buildStoryNavigation(),
                  const SizedBox(height: 24),
                  _buildFutureFeatures(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStorySegment(int index, StorySegment segment, Color accent) {
    final isActive = index <= _currentStoryIndex;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isActive ? 1 : 0.35,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withOpacity(0.85),
          border: Border.all(
            color: isActive ? const Color(0xFFFF69B4) : const Color(0xFFFFB6C1),
            width: isActive ? 2 : 1,
          ),
          boxShadow:
              isActive
                  ? const [
                    BoxShadow(
                      color: Color(0x33FF69B4),
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [accent, Colors.pink.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: const Color(0xFFFF69B4),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      segment.imageEmoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${segment.age}歳',
                  style: const TextStyle(
                    color: Color(0xFFB91C1C),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    segment.title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFFB91C1C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    segment.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4C1D95),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryNavigation() {
    if (_currentStoryIndex < _story.length - 1) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => setState(() => _currentStoryIndex += 1),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('次の記憶へ →', style: TextStyle(fontSize: 16))],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFFB6C1)),
          ),
          child: Column(
            children: [
              const Icon(Icons.favorite, color: Color(0xFFB91C1C), size: 32),
              const SizedBox(height: 8),
              const Text(
                '記憶の復元完了',
                style: TextStyle(color: Color(0xFFB91C1C), fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text(
                '継続的な睡眠でより豊かな人生を',
                style: TextStyle(color: Color(0xFF4C1D95), fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed:
                    () => setState(() {
                      _showStory = false;
                      _currentStoryIndex = 0;
                    }),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(color: Color(0xFFFFB6C1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.rotate_left, color: Color(0xFFB91C1C)),
                    SizedBox(width: 6),
                    Text('もう一度見る', style: TextStyle(color: Color(0xFFB91C1C))),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onBack,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.home, color: Colors.white),
                    SizedBox(width: 6),
                    Text('ダッシュボードへ', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFutureFeatures() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFB6C1)),
      ),
      child: const Text(
        '追加予定機能：図鑑登録 / 彼女の部屋 / 転生システム / ボイス再生',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF4C1D95), fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: _showStory ? _buildStoryView() : _buildMorningView(),
    );
  }
}
