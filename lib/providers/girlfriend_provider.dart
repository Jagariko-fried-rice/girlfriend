import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/girlfriend.dart';

part 'girlfriend_provider.g.dart';

// ガールフレンド設定を管理
@riverpod
class GirlfriendNotifier extends _$GirlfriendNotifier {
  @override
  Girlfriend? build() => null;

  void setGirlfriend(Girlfriend girlfriend) {
    state = girlfriend;
  }

  void updateRelationLevel(int level) {
    if (state != null) {
      state = state!.copyWith(relationLevel: level.clamp(0, 100));
    }
  }

  void clearGirlfriend() {
    state = null;
  }

  bool get hasGirlfriend => state != null;
}

// ガールフレンド取得プロバイダー
@riverpod
Girlfriend? currentGirlfriend(CurrentGirlfriendRef ref) {
  return ref.watch(girlfriendNotifierProvider);
}
