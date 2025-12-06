import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/opening_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Girlfriend AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppFlow(),
    );
  }
}

class AppFlow extends StatefulWidget {
  const AppFlow({super.key});

  @override
  State<AppFlow> createState() => _AppFlowState();
}

class _AppFlowState extends State<AppFlow> {
  bool _showOpening = true;

  @override
  Widget build(BuildContext context) {
    if (_showOpening) {
      return OpeningScreen(
        onComplete: () {
          setState(() {
            _showOpening = false;
          });
        },
      );
    }
    
    return LoginScreen(
      onComplete: (data) {
        debugPrint('Login completed: $data');
        // Navigate to next screen or handle login success
      },
    );
  }
}
