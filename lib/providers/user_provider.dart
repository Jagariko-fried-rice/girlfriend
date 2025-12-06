import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_provider.g.dart';

// ユーザー認証状態を管理
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() => null;

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  bool get isLoggedIn => state != null;
}

// ログイン情報プロバイダー
@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  return ref.watch(userNotifierProvider) != null;
}
