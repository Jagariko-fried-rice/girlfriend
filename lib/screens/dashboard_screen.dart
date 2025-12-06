import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'alarm_screen.dart';
import 'girlfriend_setup_screen.dart';

class DashboardScreen extends StatefulWidget {
  final GirlfriendConfig girlfriendConfig;
  final String userName;
  final String sleepTime;
  final void Function(Map<String, String> sleepData)? onDive;

  const DashboardScreen({
    super.key,
    required this.girlfriendConfig,
    this.userName = 'あなた',
    this.sleepTime = '23:00',
    this.onDive,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TimeOfDay _bedtime;
  late TimeOfDay _wakeTime;
  final Random _random = Random();
  late List<BubbleData> _bubbles;

  final Map<String, Color> hairColorMap = {
    'pink': const Color(0xFFFF69B4),
    'blue': const Color(0xFF4169E1),
    'purple': const Color(0xFF9370DB),
    'silver': const Color(0xFFC0C0C0),
    'red': const Color(0xFFDC143C),
    'blonde': const Color(0xFFFFD700),
  };

  @override
  void initState() {
    super.initState();
    _bedtime =
        _parseTime(widget.sleepTime) ?? const TimeOfDay(hour: 23, minute: 0);
    _wakeTime = const TimeOfDay(hour: 7, minute: 0);

    _bubbles = List.generate(
      30,
      (index) => BubbleData(
        id: index,
        size: _random.nextDouble() * 80 + 20,
        left: _random.nextDouble(),
        duration: _random.nextDouble() * 10 + 15,
        delay: _random.nextDouble() * 10,
      ),
    );
  }

  TimeOfDay? _parseTime(String time) {
    try {
      final parts = time.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickTime(BuildContext context, bool isBed) async {
    final initial = isBed ? _bedtime : _wakeTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: const Color(0xFF1A103C),
              hourMinuteTextColor: Colors.white,
              dayPeriodTextColor: Colors.white70,
              dialHandColor: Colors.purpleAccent,
              dialBackgroundColor: Colors.white10,
              entryModeIconColor: Colors.purpleAccent,
              helpTextStyle: TextStyle(color: Colors.purple[200]),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.purpleAccent),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isBed)
          _bedtime = picked;
        else
          _wakeTime = picked;
      });
    }
  }

  String _calculateSleepDuration() {
    final now = DateTime.now();
    final bed = DateTime(
      now.year,
      now.month,
      now.day,
      _bedtime.hour,
      _bedtime.minute,
    );
    var wake = DateTime(
      now.year,
      now.month,
      now.day,
      _wakeTime.hour,
      _wakeTime.minute,
    );
    if (wake.isBefore(bed)) {
      wake = wake.add(const Duration(days: 1));
    }
    final diff = wake.difference(bed);
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    return '$hours時間$minutes分';
  }

  void _handleDive() {
    final bedtimeStr = _bedtime.format(context);
    final wakeStr = _wakeTime.format(context);
    widget.onDive?.call({'bedtime': bedtimeStr, 'wakeTime': wakeStr});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('夢の世界へダイブします… $bedtimeStr → $wakeStr'),
        backgroundColor: Colors.purple[900],
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => AlarmScreen(
              girlfriendConfig: widget.girlfriendConfig,
              sleepData: {'bedtime': bedtimeStr, 'wakeTime': wakeStr},
              onBack: () => Navigator.of(context).pop(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hairColor =
        hairColorMap[widget.girlfriendConfig.hairColor] ?? Colors.pink;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0520),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x804A148C), // purple-900/50
                  Color(0x4D880E4F), // pink-900/30
                  Color(0x800D47A1), // blue-900/50
                ],
              ),
            ),
          ),

          // Bubbles
          ..._bubbles.map((b) => BubbleWidget(data: b)),

          // Soft gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [Colors.transparent, Color(0x4D0A0520)],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 32),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // XL breakpoint approx 1200
                          if (constraints.maxWidth >= 1000) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: _buildPartnerCard(hairColor),
                                ),
                                const SizedBox(width: 24),
                                Expanded(flex: 8, child: _buildMainArea()),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                _buildPartnerCard(hairColor),
                                const SizedBox(height: 24),
                                _buildMainArea(),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return GlassContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Colors.pinkAccent,
                size: 28,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '夢の世界',
                    style: TextStyle(
                      color: Color(0xFFFFC0FF),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.pinkAccent, blurRadius: 8),
                      ],
                    ),
                  ),
                  Text(
                    'ようこそ、${widget.userName}さん',
                    style: TextStyle(color: Colors.purple[200], fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.purple[900]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.purple[200]),
                const SizedBox(width: 6),
                Text(
                  '${DateTime.now().month}月${DateTime.now().day}日',
                  style: TextStyle(color: Colors.purple[200], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(Color hairColor) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x33E1BEE7))),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
                const SizedBox(width: 8),
                Text(
                  'あなたのパートナー',
                  style: TextStyle(color: Colors.pink[200], fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Avatar
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: RadialGradient(
                  colors: [
                    hairColor.withOpacity(0.25),
                    const Color(0x1AFFC8FF),
                  ],
                ),
                border: Border.all(color: const Color(0x4DFFB4FF), width: 2),
                boxShadow: [
                  BoxShadow(color: hairColor.withOpacity(0.2), blurRadius: 40),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      '👤',
                      style: TextStyle(
                        fontSize: 80,
                        shadows: [
                          BoxShadow(
                            color: hairColor.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Text(
                        'レベル 1',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0x14FFC8FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x33FFB4FF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.girlfriendConfig.name,
                  style: TextStyle(color: Colors.pink[100], fontSize: 24),
                ),
                Text(
                  '仮想生命体パートナー',
                  style: TextStyle(color: Colors.purple[200], fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _buildInfoRow('性格', widget.girlfriendConfig.personality),
          const SizedBox(height: 12),
          _buildInfoRow('声', widget.girlfriendConfig.voice),
          const SizedBox(height: 12),
          _buildInfoRow(
            '髪の色',
            widget.girlfriendConfig.hairColor,
            colorDot: hairColor,
          ),
          const SizedBox(height: 12),
          _buildInfoRow('服装', widget.girlfriendConfig.outfit),

          const SizedBox(height: 20),
          const Divider(color: Color(0x33E1BEE7)),
          const SizedBox(height: 12),

          // Bond
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '絆の深さ',
                style: TextStyle(color: Colors.purple[200], fontSize: 14),
              ),
              Text(
                '15 / 100',
                style: TextStyle(color: Colors.pink[200], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0x33FFC8FF)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.15,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF69B4), Color(0xFF9370DB)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(color: Color(0x99FF69B4), blurRadius: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? colorDot}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.purple[200], fontSize: 14)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              if (colorDot != null) ...[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorDot,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: colorDot, blurRadius: 6)],
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainArea() {
    return Column(
      children: [
        // Stats
        LayoutBuilder(
          builder: (context, constraints) {
            // On very small screens, stack them. On larger, row.
            // The React code uses grid-cols-1 md:grid-cols-3.
            // Let's use Wrap or Row depending on width.
            if (constraints.maxWidth < 600) {
              return Column(
                children: [
                  _buildStatCard(Icons.access_time, '総睡眠時間', '0時間', [
                    Colors.cyan,
                    Colors.blue,
                  ]),
                  const SizedBox(height: 12),
                  _buildStatCard(Icons.bolt, 'ダイブ回数', '0回', [
                    Colors.pinkAccent,
                    Colors.purple,
                  ]),
                  const SizedBox(height: 12),
                  _buildStatCard(Icons.favorite, '記憶の数', '0個', [
                    Colors.purple,
                    Colors.pink,
                  ]),
                ],
              );
            }
            return Row(
              children: [
                Expanded(
                  child: _buildStatCard(Icons.access_time, '総睡眠時間', '0時間', [
                    Colors.cyan,
                    Colors.blue,
                  ]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(Icons.bolt, 'ダイブ回数', '0回', [
                    Colors.pinkAccent,
                    Colors.purple,
                  ]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(Icons.favorite, '記憶の数', '0個', [
                    Colors.purple,
                    Colors.pink,
                  ]),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),

        // Sleep Dive Settings
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0x33E1BEE7))),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.nightlight_round,
                      color: Colors.purple[200],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '睡眠ダイブの設定',
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Time Inputs
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        _buildTimeInput(
                          '就寝時刻',
                          _bedtime,
                          () => _pickTime(context, true),
                        ),
                        const SizedBox(height: 16),
                        _buildTimeInput(
                          '起床時刻',
                          _wakeTime,
                          () => _pickTime(context, false),
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: _buildTimeInput(
                          '就寝時刻',
                          _bedtime,
                          () => _pickTime(context, true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTimeInput(
                          '起床時刻',
                          _wakeTime,
                          () => _pickTime(context, false),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // Duration
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0x1A9370DB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x4D9370DB)),
                  boxShadow: const [
                    BoxShadow(color: Color(0x1A9370DB), blurRadius: 30),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '予定睡眠時間',
                      style: TextStyle(color: Colors.purple[200], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _calculateSleepDuration(),
                      style: const TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0x14FFC8FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x33FFB4FF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 16,
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '夢からのメッセージ',
                          style: TextStyle(
                            color: Colors.pink[200],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '・推奨睡眠時間は7〜8時間です',
                      style: TextStyle(color: Colors.purple[100], fontSize: 13),
                    ),
                    Text(
                      '・設定時刻に近いほど、より美しい思い出が紡がれます',
                      style: TextStyle(color: Colors.purple[100], fontSize: 13),
                    ),
                    Text(
                      '・毎日の睡眠が、彼女との絆を深めていきます',
                      style: TextStyle(color: Colors.purple[100], fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFBA55D3).withOpacity(0.4),
                      const Color(0xFF9370DB).withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x66FFC8FF), width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4DBA55D3),
                      blurRadius: 30,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _handleDive,
                    borderRadius: BorderRadius.circular(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.nightlight_round, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          '夢の世界へダイブする',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String label,
    String value,
    List<Color> gradientColors,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.purple[200], size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: Colors.purple[200], fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback:
                (bounds) =>
                    LinearGradient(colors: gradientColors).createShader(bounds),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInput(String label, TimeOfDay time, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.purple[200], fontSize: 14)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x4DFFC8FF)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1AFF96FF),
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time.format(context),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Icon(Icons.access_time, color: Colors.purple[200], size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x40FFB4FF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1AFF00FF),
                blurRadius: 32,
                offset: Offset(0, 8),
              ),
              BoxShadow(color: Color(0x0DFFFFFF), blurRadius: 30),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class BubbleData {
  final int id;
  final double size;
  final double left;
  final double duration;
  final double delay;

  BubbleData({
    required this.id,
    required this.size,
    required this.left,
    required this.duration,
    required this.delay,
  });
}

class BubbleWidget extends StatefulWidget {
  final BubbleData data;

  const BubbleWidget({super.key, required this.data});

  @override
  State<BubbleWidget> createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.data.duration.toInt()),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(
      Duration(milliseconds: (widget.data.delay * 1000).toInt()),
      () {
        if (mounted) _controller.repeat();
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final value = _animation.value;
        final bottom =
            -100 + (MediaQuery.of(context).size.height + 200) * value;
        final opacity =
            value < 0.1 ? value * 6 : (value > 0.9 ? (1 - value) * 6 : 0.6);

        return Positioned(
          left:
              MediaQuery.of(context).size.width * widget.data.left +
              sin(value * 2 * pi) * 20,
          bottom: bottom,
          child: Opacity(
            opacity: opacity.clamp(0.0, 0.6),
            child: Container(
              width: widget.data.size,
              height: widget.data.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  center: Alignment(0.3, 0.3),
                  colors: [
                    Color(0xCCFFFFFF),
                    Color(0x4DFFC8FF),
                    Color(0x1AC896FF),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4DFFFFFF),
                    blurRadius: 20,
                    offset: Offset(-10, -10),
                  ),
                  BoxShadow(
                    color: Color(0x33FFC8FF),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                  BoxShadow(color: Color(0x4DFF96FF), blurRadius: 20),
                ],
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
        );
      },
    );
  }
}
