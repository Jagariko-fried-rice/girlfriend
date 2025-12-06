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
  final int _particleCount = 25;
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
        size: 3 + _random.nextDouble() * 6,
        delay: _random.nextDouble() * 2,
        speed: 3 + _random.nextDouble() * 4,
        opacity: 0.4 + _random.nextDouble() * 0.6,
        color: _random.nextBool()
            ? const Color(0xFF00D9FF)
            : const Color(0xFFFF00FF),
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
    if (newTime != null) {
      setState(() {
        _sleepTime = newTime;
        _sleepController.text = _sleepTime.format(context);
      });
    }
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ようこそ、${data.name}さん！ ✨'),
          backgroundColor: const Color(0xFFFF00FF),
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
        child: Stack(
          children: [
            // Animated Particles (Stars/Sparkles)
            ..._particles.map(
              (p) => Positioned(
                left: p.left * MediaQuery.of(context).size.width,
                top: p.top * MediaQuery.of(context).size.height,
                child: AnimatedParticle(
                  size: p.size,
                  delay: p.delay,
                  speed: p.speed,
                  opacity: p.opacity,
                  color: p.color,
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
                      const SizedBox(height: 12),
                      // Logo / Title with cute icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.favorite,
                            color: Color(0xFFFF0080),
                            size: 32,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.nightlight_round,
                            color: Color(0xFF00D9FF),
                            size: 44,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.auto_awesome,
                            color: Color(0xFFFF00FF),
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '彼女の人生',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF66FF),
                          shadows: [
                            Shadow(blurRadius: 15, color: Color(0xFFFF00FF)),
                            Shadow(blurRadius: 30, color: Color(0xFF00D9FF)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF00D9FF),
                              Color(0xFFFF00FF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Virtual Life Simulator',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Ver 5.0.XX - AI Partner System ✨',
                        style: TextStyle(
                          color: Color(0xFF00D9FF),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Form Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFFF00FF).withValues(alpha: 0.5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF00FF).withValues(alpha: 0.3),
                                  blurRadius: 30,
                                  spreadRadius: 2,
                                ),
                                BoxShadow(
                                  color: const Color(0xFF00D9FF).withValues(alpha: 0.2),
                                  blurRadius: 40,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Name
                                  const FieldLabel(
                                    label: 'マスター名',
                                    icon: Icons.person,
                                  ),
                                  TextFormField(
                                    controller: _nameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration('あなたの名前を入力'),
                                    validator: (val) =>
                                        (val == null || val.trim().isEmpty)
                                            ? '必須項目です'
                                            : null,
                                  ),
                                  const SizedBox(height: 16),

                                  // Sleep time
                                  const FieldLabel(
                                    label: '推奨睡眠時刻',
                                    icon: Icons.bedtime,
                                  ),
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
                                          suffix: const Icon(
                                            Icons.access_time,
                                            color: Color(0xFF00D9FF),
                                          ),
                                        ),
                                        validator: (val) =>
                                            (val == null || val.trim().isEmpty)
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
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.favorite,
                                          size: 14,
                                          color: Color(0xFFFF0080),
                                        ),
                                        SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            '睡眠時刻に近いほど理想の彼女に近づきます',
                                            style: TextStyle(
                                              color: Color(0xFF00D9FF),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Email
                                  const FieldLabel(
                                    label: 'メールアドレス',
                                    icon: Icons.email,
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      'example@email.com',
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return '必須項目です';
                                      }
                                      final emailRegex = RegExp(
                                        r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}",
                                      );
                                      if (!emailRegex.hasMatch(val)) {
                                        return '有効なメールアドレスを入力してください';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Age
                                  const FieldLabel(
                                    label: '年齢',
                                    icon: Icons.cake,
                                  ),
                                  TextFormField(
                                    controller: _ageController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration('18'),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return '必須項目です';
                                      }
                                      final n = int.tryParse(val);
                                      if (n == null || n < 1 || n > 120) {
                                        return '年齢を正しく入力してください';
                                      }
                                      return null;
                                    },
                                  ),

                                  // Submit
                                  const SizedBox(height: 24),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFF0080),
                                          Color(0xFFFF00FF),
                                          Color(0xFF00D9FF),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFFF00FF)
                                              .withValues(alpha: 0.6),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _submit,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.auto_awesome,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'システムにログイン',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Info
                                  const SizedBox(height: 16),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00D9FF)
                                            .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF00D9FF)
                                              .withValues(alpha: 0.4),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.info_outline,
                                            color: Color(0xFF00D9FF),
                                            size: 16,
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'このシステムは睡眠改善を目的としています',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
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
    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.1),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFFF00FF),
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFFF0080),
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFFF0080),
        width: 2,
      ),
    ),
    suffixIcon: suffix != null
        ? Padding(padding: const EdgeInsets.only(right: 12), child: suffix)
        : null,
  );
}

class FieldLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  const FieldLabel({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF00D9FF),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            '*',
            style: TextStyle(
              color: Color(0xFFFF0080),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
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
  final Color color;

  _ParticleInfo({
    required this.left,
    required this.top,
    required this.size,
    required this.delay,
    required this.speed,
    required this.opacity,
    required this.color,
  });
}

class AnimatedParticle extends StatefulWidget {
  final double size;
  final double delay;
  final double speed;
  final double opacity;
  final Color color;

  const AnimatedParticle({
    Key? key,
    required this.size,
    required this.delay,
    required this.speed,
    required this.opacity,
    required this.color,
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
      begin: -8,
      end: 8,
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
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.6),
                    blurRadius: widget.size * 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
