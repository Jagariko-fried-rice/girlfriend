import 'dart:math';
import 'package:flutter/material.dart';
import 'girlfriend_setup_screen.dart';

class DashboardScreen extends StatefulWidget {
  final GirlfriendConfig girlfriendConfig;
  final String userName;
  final String sleepTime; // initial sleep time
  final void Function(Map<String, String> sleepData)? onDive;

  const DashboardScreen({super.key, required this.girlfriendConfig, this.userName = 'あなた', this.sleepTime = '23:00', this.onDive});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TimeOfDay _bedtime;
  late TimeOfDay _wakeTime;

  late final AnimationController _animationController;

  Map<String, Color> hairColorMap = {
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
    _bedtime = _parseTime(widget.sleepTime) ?? const TimeOfDay(hour: 23, minute: 0);
    _wakeTime = const TimeOfDay(hour: 7, minute: 0);

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  TimeOfDay? _parseTime(String time) {
    try {
      final parts = time.split(':');
      final h = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      return TimeOfDay(hour: h, minute: m);
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickTime(BuildContext context, bool isBed) async {
    final initial = isBed ? _bedtime : _wakeTime;
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked != null) {
      setState(() {
        if (isBed) _bedtime = picked; else _wakeTime = picked;
      });
    }
  }

  String _calculateSleepDuration() {
    final now = DateTime.now();
    final bed = DateTime(now.year, now.month, now.day, _bedtime.hour, _bedtime.minute);
    var wake = DateTime(now.year, now.month, now.day, _wakeTime.hour, _wakeTime.minute);
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
    // For demo: show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ダイブします… $bedtimeStr → $wakeStr')));
  }

  Widget _floatingImage(String url, double leftPerc, double topPerc, double rotation, double scale) {
    return Positioned(
      left: MediaQuery.of(context).size.width * leftPerc - (100 * scale),
      top: MediaQuery.of(context).size.height * topPerc - (80 * scale),
      child: Transform.rotate(
        angle: rotation * (pi / 180),
        child: Opacity(
          opacity: 0.6,
          child: Container(
            width: 280 * scale,
            height: 220 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            ),
            foregroundDecoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.girlfriendConfig;
    final hairColor = hairColorMap[cfg.hairColor] ?? Colors.pink;

    final floatingImages = [
      {
        'url': 'https://images.unsplash.com/photo-1756270410485-02a757c3e78a?q=80&w=1080',
        'rotation': 12.0,
        'left': 0.05,
        'top': 0.08,
        'scale': 1.0
      },
      {
        'url': 'https://images.unsplash.com/photo-1618902345200-8c3fe6106608?q=80&w=1080',
        'rotation': -15.0,
        'left': 0.45,
        'top': 0.2,
        'scale': 0.9
      },
      {
        'url': 'https://images.unsplash.com/photo-1762279389045-110301edeecc?q=80&w=1080',
        'rotation': 8.0,
        'left': 0.75,
        'top': 0.45,
        'scale': 1.1
      }
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0A0520), Color(0xFF120438)],
              ),
            ),
          ),

          // floating images
          ...floatingImages.map((img) => _floatingImage(img['url'] as String, img['left'] as double, img['top'] as double, img['rotation'] as double, img['scale'] as double)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.06)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.auto_awesome, color: Colors.pinkAccent),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('夢の世界', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.pink[100])),
                                    const SizedBox(height: 4),
                                    Text('ようこそ、${widget.userName}さん', style: const TextStyle(color: Colors.deepPurpleAccent)),
                                  ],
                                ),
                              ],
                            ),
                            Text('${DateTime.now().month}月${DateTime.now().day}日', style: const TextStyle(color: Colors.purpleAccent))
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Main layout
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column: profile card
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(right: 12, bottom: 36),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white.withOpacity(0.04)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite, color: Colors.pink),
                                      const SizedBox(width: 8),
                                      Text('あなたのパートナー', style: TextStyle(color: Colors.pink[200], fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  // Avatar
                                  Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: RadialGradient(colors: [hairColor.withOpacity(0.25), Colors.black.withOpacity(0.0)]),
                                      boxShadow: [BoxShadow(color: hairColor.withOpacity(0.25), blurRadius: 20, spreadRadius: 2)],
                                    ),
                                    child: Center(
                                      child: Text('👤', style: TextStyle(fontSize: 80, shadows: [BoxShadow(color: hairColor.withOpacity(0.4), blurRadius: 24)])),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(cfg.name, style: const TextStyle(fontSize: 20, color: Colors.white)),
                                  const SizedBox(height: 4),
                                  Text('仮想生命体パートナー', style: TextStyle(color: Colors.purple[200], fontSize: 12)),
                                  const SizedBox(height: 14),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('性格', style: TextStyle(color: Colors.purple[300])),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(20)),
                                            child: Text(cfg.personality, style: const TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('声', style: TextStyle(color: Colors.purple[300])),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(20)),
                                            child: Text(cfg.voice, style: const TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('髪の色', style: TextStyle(color: Colors.purple[300])),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Container(width: 18, height: 18, decoration: BoxDecoration(color: hairColor, borderRadius: BorderRadius.circular(10))),
                                              const SizedBox(width: 8),
                                              Text(cfg.hairColor, style: const TextStyle(color: Colors.white)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('服装', style: TextStyle(color: Colors.purple[300])),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(20)),
                                            child: Text(cfg.outfit, style: const TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 14),
                                  // Bond section
                                  const Divider(color: Colors.purpleAccent, height: 0.5),
                                  const SizedBox(height: 12),
                                  Text('絆の深さ', style: TextStyle(color: Colors.purple[300])),
                                  const SizedBox(height: 6),
                                  Stack(
                                    children: [
                                      Container(height: 14, decoration: BoxDecoration(color: Colors.black.withOpacity(0.25), borderRadius: BorderRadius.circular(20))),
                                      Container(height: 14, width: MediaQuery.of(context).size.width * 0.15, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink, Colors.purple]), borderRadius: BorderRadius.circular(20))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Right column: main area
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                // three small stat cards
                                Row(
                                  children: [
                                    Expanded(child: _statCard(label: '総睡眠時間', value: '0時間')),
                                    const SizedBox(width: 10),
                                    Expanded(child: _statCard(label: 'ダイブ回数', value: '0回')),
                                    const SizedBox(width: 10),
                                    Expanded(child: _statCard(label: '記憶の数', value: '0個')),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.04))),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Row(children: const [Icon(Icons.nightlight_round, color: Colors.purpleAccent), SizedBox(width: 8), Text('睡眠ダイブの設定', style: TextStyle(color: Colors.white, fontSize: 18))]),
                                    const SizedBox(height: 12),

                                    // Time pickers
                                    Row(children: [
                                      Expanded(child: _timePickerCard('就寝時刻', _bedtime, () => _pickTime(context, true))),
                                      const SizedBox(width: 12),
                                      Expanded(child: _timePickerCard('起床時刻', _wakeTime, () => _pickTime(context, false))),
                                    ]),
                                    const SizedBox(height: 12),

                                    // Duration
                                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple[900]?.withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('予定睡眠時間', style: TextStyle(color: Colors.purple[300])), const SizedBox(height: 6), Text(_calculateSleepDuration(), style: const TextStyle(fontSize: 28, color: Colors.white))])),
                                    const SizedBox(height: 12),

                                    // Tips / info
                                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('夢からのメッセージ', style: TextStyle(color: Colors.pink[200])), const SizedBox(height: 6), const Text('・推奨睡眠時間は7〜8時間です\n・設定時刻に近いほど、美しい思い出に')],),),
                                    const SizedBox(height: 12),

                                    // Dive button
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _handleDive,
                                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18), backgroundColor: Colors.purple[700], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.nightlight_round), SizedBox(width: 8), Text('夢の世界へダイブする')]),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _timePickerCard(String label, TimeOfDay t, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.purple[300])), const SizedBox(height: 8), Text(t.format(context), style: const TextStyle(color: Colors.white, fontSize: 18))]),
      ),
    );
  }

  Widget _statCard({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.purple[300])), const SizedBox(height: 6), Text(value, style: const TextStyle(color: Colors.white, fontSize: 20))]),
    );
  }
}
