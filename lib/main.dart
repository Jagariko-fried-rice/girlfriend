import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/opening_screen.dart';
import 'screens/girlfriend_setup_screen.dart';

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

enum AppStage { opening, login, setup, home }

class AppFlow extends StatefulWidget {
  const AppFlow({super.key});

  @override
  State<AppFlow> createState() => _AppFlowState();
}

class _AppFlowState extends State<AppFlow> {
  AppStage _stage = AppStage.opening;

  @override
  Widget build(BuildContext context) {
    switch (_stage) {
      case AppStage.opening:
        return OpeningScreen(
          onComplete: () {
            setState(() {
              _stage = AppStage.login;
            });
          },
        );
      case AppStage.login:
        return LoginScreen(
          onComplete: (data) {
            debugPrint('Login completed: $data');
            setState(() {
              _stage = AppStage.setup;
            });
          },
        );
      case AppStage.setup:
        return GirlfriendSetupScreen(
          onComplete: (config) {
            debugPrint('Setup completed: $config');
            // Navigate to home or next screen
            setState(() {
              _stage = AppStage.home;
            });
          },
        );
      case AppStage.home:
        return const Scaffold(
          body: Center(
            child: Text('Home Screen (To be implemented)'),
          ),
        );
    }
  }
}
