import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/agent.dart';

part 'agent_provider.g.dart';

// エージェント管理
@riverpod
class AgentNotifier extends _$AgentNotifier {
  @override
  Agent? build() => null;

  void setAgent(Agent agent) {
    state = agent;
  }

  void updateScore(int scoreRecent) {
    if (state != null) {
      final newTotal = state!.scoreTotal + scoreRecent;
      state = state!.copyWith(scoreRecent: scoreRecent, scoreTotal: newTotal);
    }
  }

  void evolve() {
    if (state != null) {
      state = state!.copyWith(
        generation: state!.generation + 1,
        scoreRecent: 0,
      );
    }
  }

  void clearAgent() {
    state = null;
  }

  bool get hasAgent => state != null;
}

// 現在のエージェント取得
@riverpod
Agent? currentAgent(CurrentAgentRef ref) {
  return ref.watch(agentNotifierProvider);
}

// エージェント進化可否判定
@riverpod
bool canEvolveAgent(CanEvolveAgentRef ref) {
  final agent = ref.watch(agentNotifierProvider);
  if (agent == null) return false;
  // 進化条件: scoreRecent が200以上
  return agent.scoreRecent >= 200;
}
