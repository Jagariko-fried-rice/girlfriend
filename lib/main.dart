import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/opening_screen.dart';
import 'screens/girlfriend_setup_screen.dart';
import 'providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

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
