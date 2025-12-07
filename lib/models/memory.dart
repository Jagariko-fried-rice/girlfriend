import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory.freezed.dart';

@freezed
class Memory with _$Memory {
  const factory Memory({
    required String id,
    required String partnerId,
    required String scenarioId,
    required String generatedPrompt,
    required DateTime occurredAt,
  }) = _Memory;

  factory Memory.fromSupabase(Map<String, dynamic> json) => Memory(
    id: json['id'] as String,
    partnerId: json['partner_id'] as String,
    scenarioId: json['scenario_id'] as String,
    generatedPrompt: json['generated_prompt'] as String,
    occurredAt: DateTime.parse(json['occurred_at'] as String),
  );

  static Map<String, dynamic> toSupabase(Memory memory) => {
    'id': memory.id,
    'partner_id': memory.partnerId,
    'scenario_id': memory.scenarioId,
    'generated_prompt': memory.generatedPrompt,
    'occurred_at': memory.occurredAt.toIso8601String(),
  };
}
