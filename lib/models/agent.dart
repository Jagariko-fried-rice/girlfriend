import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent.freezed.dart';

@freezed
class Agent with _$Agent {
  const factory Agent({
    required String id,
    required String name,
    required int generation,
    required int scoreTotal,
    required int scoreRecent,
    required String personalityType, // Brave, Calm, Logic, Random
    required Map<String, dynamic> behaviorBias,
    String? partnerId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Agent;
}
