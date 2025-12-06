import 'dart:ui';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class GirlfriendConfig {
  final String name;
  final String personality;
  final String voice;
  final String hairColor;
  final String outfit;

  GirlfriendConfig({
    required this.name,
    required this.personality,
    required this.voice,
    required this.hairColor,
    required this.outfit,
  });

  @override
  String toString() {
    return 'GirlfriendConfig(name: $name, personality: $personality, voice: $voice, hairColor: $hairColor, outfit: $outfit)';
  }
}

class GirlfriendSetupScreen extends StatefulWidget {
  final void Function(GirlfriendConfig config) onComplete;

  const GirlfriendSetupScreen({super.key, required this.onComplete});

  @override
  State<GirlfriendSetupScreen> createState() => _GirlfriendSetupScreenState();
}

class _GirlfriendSetupScreenState extends State<GirlfriendSetupScreen> {
  final _nameController = TextEditingController();
  
  // Default values matching React state
  String _personality = 'tsundere';
  String _voice = 'soft';
  String _hairColor = 'pink';
  String _outfit = 'school';

  final List<Map<String, String>> _personalities = [
    {'id': 'tsundere', 'label': 'ツンデレ', 'desc': '素直になれない可愛さ'},
    {'id': 'genki', 'label': '元気系', 'desc': '明るく前向きな性格'},
    {'id': 'cool', 'label': 'クール系', 'desc': '落ち着いた大人の魅力'},
    {'id': 'yandere', 'label': 'ヤンデレ', 'desc': '一途すぎる愛情表現'},
  ];

  final List<Map<String, String>> _voices = [
    {'id': 'soft', 'label': '優しい声', 'desc': '癒し系ボイス'},
    {'id': 'energetic', 'label': '元気な声', 'desc': 'ハイテンションボイス'},
    {'id': 'mature', 'label': '大人の声', 'desc': '落ち着いたボイス'},
    {'id': 'cute', 'label': '可愛い声', 'desc': '萌え系ボイス'},
  ];

  final List<Map<String, dynamic>> _hairColors = [
    {'id': 'pink', 'label': 'ピンク', 'color': const Color(0xFFFF69B4)},
    {'id': 'blue', 'label': 'ブルー', 'color': const Color(0xFF4169E1)},
    {'id': 'purple', 'label': 'パープル', 'color': const Color(0xFF9370DB)},
    {'id': 'silver', 'label': 'シルバー', 'color': const Color(0xFFC0C0C0)},
    {'id': 'red', 'label': 'レッド', 'color': const Color(0xFFDC143C)},
    {'id': 'blonde', 'label': 'ブロンド', 'color': const Color(0xFFFFD700)},
  ];

  final List<Map<String, String>> _outfits = [
    {'id': 'school', 'label': '学生服', 'desc': '青春の制服'},
    {'id': 'casual', 'label': 'カジュアル', 'desc': '普段着スタイル'},
    {'id': 'gothic', 'label': 'ゴシック', 'desc': 'ダークな魅力'},
    {'id': 'maid', 'label': 'メイド服', 'desc': 'ご主人様仕様'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.isNotEmpty) {
      final config = GirlfriendConfig(
        name: _nameController.text,
        personality: _personality,
        voice: _voice,
        hairColor: _hairColor,
        outfit: _outfit,
      );
      // Call parent callback if provided
      widget.onComplete(config);

      // Navigate to the Dashboard screen, passing the newly created Girlfriend config
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            girlfriendConfig: config,
            userName: _nameController.text,
            sleepTime: '23:00',
            onDive: (sleepData) {
              // Default behavior — show a dialog to demonstrate callback
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('ダイブ開始'),
                  content: Text('就寝: ${sleepData['bedtime']} → 起床: ${sleepData['wakeTime']}'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('閉じる')),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800), // max-w-4xl
                child: Column(
                  children: [
                    // Header
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.favorite, color: Color(0xFFFF0080), size: 32), // Pink-400 approx
                        SizedBox(width: 8),
                        Icon(Icons.auto_awesome, color: Color(0xFF00D9FF), size: 24), // Cyan-400 approx
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '彼女の設定',
                      style: TextStyle(
                        fontSize: 36, // text-3xl/4xl
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF00FF),
                        shadows: [
                          Shadow(color: Color(0xFFFF00FF), blurRadius: 10),
                          Shadow(color: Color(0xFF00D9FF), blurRadius: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'あなただけのパートナーをデザインしてください',
                      style: TextStyle(color: Color(0xFF00D9FF), fontSize: 14),
                    ),
                    const SizedBox(height: 32),

                    // Form Container
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A0A2E).withValues(alpha: 0.8), // rgba(26, 10, 46, 0.8)
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFFF00FF).withValues(alpha: 0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF00FF).withValues(alpha: 0.2),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              _buildSectionLabel('彼女の名前', required: true),
                              TextField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                                onChanged: (_) => setState(() {}),
                                decoration: InputDecoration(
                                  hintText: '記憶の彼方にいる彼女の名前を...',
                                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                                  filled: true,
                                  fillColor: Colors.black.withValues(alpha: 0.5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.purple),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.purple),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color(0xFFFF69B4)), // pink-400
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Personality
                              _buildSectionLabel('性格タイプ'),
                              GridView.count(
                                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 3.5,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: _personalities.map((p) => _buildSelectionCard(
                                  id: p['id']!,
                                  label: p['label']!,
                                  desc: p['desc']!,
                                  isSelected: _personality == p['id'],
                                  onTap: () => setState(() => _personality = p['id']!),
                                )).toList(),
                              ),
                              const SizedBox(height: 32),

                              // Voice
                              _buildSectionLabel('ボイスタイプ'),
                              GridView.count(
                                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 3.5,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: _voices.map((v) => _buildSelectionCard(
                                  id: v['id']!,
                                  label: v['label']!,
                                  desc: v['desc']!,
                                  isSelected: _voice == v['id'],
                                  onTap: () => setState(() => _voice = v['id']!),
                                )).toList(),
                              ),
                              const SizedBox(height: 32),

                              // Hair Color
                              _buildSectionLabel('髪の色'),
                              GridView.count(
                                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.0,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: _hairColors.map((h) => _buildColorCard(
                                  id: h['id'] as String,
                                  label: h['label'] as String,
                                  color: h['color'] as Color,
                                  isSelected: _hairColor == h['id'],
                                  onTap: () => setState(() => _hairColor = h['id'] as String),
                                )).toList(),
                              ),
                              const SizedBox(height: 32),

                              // Outfit
                              _buildSectionLabel('服装スタイル'),
                              GridView.count(
                                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 3.5,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: _outfits.map((o) => _buildSelectionCard(
                                  id: o['id']!,
                                  label: o['label']!,
                                  desc: o['desc']!,
                                  isSelected: _outfit == o['id'],
                                  onTap: () => setState(() => _outfit = o['id']!),
                                )).toList(),
                              ),
                              const SizedBox(height: 32),

                              // Coming Soon
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.purple.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        text: '追加予定機能：',
                                        style: TextStyle(color: Color(0xFF00D9FF)),
                                      ),
                                      TextSpan(text: ' 肌の色 / 塾・習い事 / 出身国 / 世界観設定'),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Submit Button
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFDB2777), Color(0xFF9333EA)], // pink-600 to purple-600
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF00FF).withValues(alpha: 0.5),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _nameController.text.isNotEmpty ? _submit : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.favorite, size: 20, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        '彼女を誕生させる',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.auto_awesome, size: 20, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: Color(0xFF00D9FF)), // cyan-400
          children: [
            TextSpan(text: text),
            if (required)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Color(0xFFFF69B4)), // pink-400
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required String id,
    required String label,
    required String desc,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFF69B4).withValues(alpha: 0.2) // pink-500/20
                : Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFFF69B4) // pink-400
                  : Colors.purple.withValues(alpha: 0.5),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorCard({
    required String id,
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.25), // 0.25 alpha approx for 40 hex
                      Colors.transparent,
                    ],
                  )
                : null,
            color: isSelected ? null : const Color(0xFF000000).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFFF69B4) // pink-400
                  : Colors.purple.withValues(alpha: 0.5),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
