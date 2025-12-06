import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/login_screen.dart';
import 'screens/opening_screen.dart';
import 'screens/girlfriend_setup_screen.dart';
import 'providers/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

class AppFlow extends ConsumerWidget {
  const AppFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(appStateNotifierProvider);

    switch (stage) {
      case AppStage.opening:
        return OpeningScreen(
          onComplete: () {
            ref.read(appStateNotifierProvider.notifier).moveToLogin();
          },
        );
      case AppStage.login:
        return LoginScreen(
          onComplete: (data) {
            debugPrint('Login completed: $data');
            ref.read(appStateNotifierProvider.notifier).moveToSetup();
          },
        );
      case AppStage.setup:
        return GirlfriendSetupScreen(
          onComplete: (config) {
            debugPrint('Setup completed: $config');
            ref.read(appStateNotifierProvider.notifier).moveToHome();
          },
        );
      case AppStage.home:
        return const Scaffold(
          body: Center(child: Text('Home Screen (To be implemented)')),
        );
    }
  }
}
