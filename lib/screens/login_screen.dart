import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class LoginData {
  final String name;
  final String sleepTime;
  final String email;
  final String age;

  LoginData({
    required this.name,
    required this.sleepTime,
    required this.email,
    required this.age,
  });

  @override
  String toString() =>
      'LoginData(name: $name, sleepTime: $sleepTime, email: $email, age: $age)';
}

class LoginScreen extends StatefulWidget {
  final void Function(LoginData data)? onComplete;
  const LoginScreen({Key? key, this.onComplete}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  late TimeOfDay _sleepTime = TimeOfDay(hour: 23, minute: 0);
  final _sleepController = TextEditingController();

  final _random = Random();
  final int _particleCount = 20;
  late final List<_ParticleInfo> _particles;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sleepController.text = _sleepTime.format(context);
    });
    _particles = List.generate(_particleCount, (index) {
      return _ParticleInfo(
        left: _random.nextDouble(),
        top: _random.nextDouble(),
        size: 2 + _random.nextDouble() * 4,
        delay: _random.nextDouble() * 2,
        speed: 3 + _random.nextDouble() * 4,
        opacity: 0.3 + _random.nextDouble() * 0.7,
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _sleepController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: _sleepTime,
    );
    if (newTime != null)
      setState(() {
        _sleepTime = newTime;
        _sleepController.text = _sleepTime.format(context);
      });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final data = LoginData(
        name: _nameController.text.trim(),
        sleepTime: _sleepTime.format(context),
        email: _emailController.text.trim(),
        age: _ageController.text.trim(),
      );

      if (widget.onComplete != null) widget.onComplete!(data);

      // For demo: show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in: ${data.name} • ${data.sleepTime}')),
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
            colors: [Color(0xFF4A0E62), Colors.black, Color(0xFF29004C)], // Brighter Purple Gradient
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Particles
            ..._particles.map(
              (p) => Positioned(
                left: p.left * MediaQuery.of(context).size.width,
                top: p.top * MediaQuery.of(context).size.height,
                child: AnimatedParticle(
                  size: p.size,
                  delay: p.delay,
                  speed: p.speed,
                  opacity: p.opacity,
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo / Title
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFFF7BA9),
                            size: 44,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.auto_fix_high,
                            color: Color(0xFF00EDFF),
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '彼女の人生',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF40FF), // Brighter Pink
                          shadows: [
                            Shadow(blurRadius: 10, color: Color(0xFFFF00FF)),
                            Shadow(blurRadius: 30, color: Color(0xFFD500F9)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Virtual Life Simulator',
                        style: TextStyle(
                          color: Color(0xFF00EDFF),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Ver 5.0.XX - AI Partner System',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 18),

                      // Form Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(26, 10, 46, 0.78),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.purple.withValues(alpha: 0.4),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x50FF00FF), // Stronger glow
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Name
                                  const FieldLabel(label: 'マスター名'),
                                  TextFormField(
                                    controller: _nameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration('あなたの名前を入力'),
                                    validator:
                                        (val) =>
                                            (val == null || val.trim().isEmpty)
                                                ? '必須項目です'
                                                : null,
                                  ),
                                  const SizedBox(height: 12),

                                  // Sleep time
                                  const FieldLabel(label: '推奨睡眠時刻'),
                                  GestureDetector(
                                    onTap: _pickTime,
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: _sleepController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _inputDecoration(
                                          '23:00',
                                          suffix: Icon(
                                            Icons.access_time,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        validator:
                                            (val) =>
                                                (val == null ||
                                                        val.trim().isEmpty)
                                                    ? '必須項目です'
                                                    : null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                      bottom: 6,
                                    ),
                                    child: Text(
                                      '睡眠時刻に近いほど理想の彼女に近づきます',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  // Email
                                  const FieldLabel(label: 'メールアドレス'),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      'example@email.com',
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty)
                                        return '必須項目です';
                                      final emailRegex = RegExp(
                                        r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}",
                                      );
                                      if (!emailRegex.hasMatch(val))
                                        return '有効なメールアドレスを入力してください';
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),

                                  // Age
                                  const FieldLabel(label: '年齢'),
                                  TextFormField(
                                    controller: _ageController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration('18'),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty)
                                        return '必須項目です';
                                      final n = int.tryParse(val);
                                      if (n == null || n < 1 || n > 120)
                                        return '年齢を正しく入力してください';
                                      return null;
                                    },
                                  ),

                                  // Submit
                                  const SizedBox(height: 18),
                                  ElevatedButton(
                                    onPressed: _submit,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadowColor: const Color(0xFFEA00FF),
                                      elevation: 8,
                                      backgroundColor: Colors.transparent,
                                      // gradient background below
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFF00CC), // Brighter Pink
                                            Color(0xFFD500F9), // Vivid Purple
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xAAFF00FF), // Stronger glow
                                            blurRadius: 25,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.auto_fix_high,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'システムにログイン',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.auto_fix_high,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Warning
                                  const SizedBox(height: 12),
                                  const Center(
                                    child: Text(
                                      'このシステムは睡眠改善を目的としています\n健康的な睡眠習慣を促進します',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

InputDecoration _inputDecoration(String placeholder, {Widget? suffix}) {
  return InputDecoration(
    hintText: placeholder,
    hintStyle: const TextStyle(color: Colors.white54),
    filled: true,
    fillColor: Colors.black45,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.purple.withValues(alpha: 0.6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFFF40FF), width: 2), // Brighter Pink border
    ),
    suffixIcon:
        suffix != null
            ? Padding(padding: const EdgeInsets.only(right: 12), child: suffix)
            : null,
  );
}

class FieldLabel extends StatelessWidget {
  final String label;
  const FieldLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF00EDFF), fontSize: 13),
          ),
          const SizedBox(width: 6),
          const Text(
            '*',
            style: TextStyle(color: Color(0xFFFF40FF), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ParticleInfo {
  final double left;
  final double top;
  final double size;
  final double delay;
  final double speed;
  final double opacity;

  _ParticleInfo({
    required this.left,
    required this.top,
    required this.size,
    required this.delay,
    required this.speed,
    required this.opacity,
  });
}

class AnimatedParticle extends StatefulWidget {
  // left/topを削除
  final double size;
  final double delay;
  final double speed;
  final double opacity;

  const AnimatedParticle({
    Key? key,
    required this.size,
    required this.delay,
    required this.speed,
    required this.opacity,
  }) : super(key: key);

  @override
  State<AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.speed * 1000).toInt()),
    );
    _anim = Tween<double>(
      begin: -6,
      end: 6,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _anim.value),
          child: Opacity(
            opacity: widget.opacity,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: const BoxDecoration(
                color: Color(0xFF00EDFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
