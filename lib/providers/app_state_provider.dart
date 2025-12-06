import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

enum AppStage { opening, login, setup, home }

// アプリのナビゲーション状態を管理
@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppStage build() => AppStage.opening;

  void moveToLogin() => state = AppStage.login;
  void moveToSetup() => state = AppStage.setup;
  void moveToHome() => state = AppStage.home;
  void reset() => state = AppStage.opening;
}
