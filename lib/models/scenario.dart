import 'package:freezed_annotation/freezed_annotation.dart';

part 'scenario.freezed.dart';

@freezed
class Scenario with _$Scenario {
  const factory Scenario({
    required String id,
    required String stage,
    required String routes,
    required String templateText,
    required Map<String, dynamic> statEffect,
    required int weight,
    String? conditionStat,
    @Default(0) int conditionValue,
    String? successText,
    String? failureText,
    @Default({}) Map<String, dynamic> successEffect,
    @Default({}) Map<String, dynamic> failureEffect,
    String? imagePrompt,
  }) = _Scenario;

  factory Scenario.fromSupabase(Map<String, dynamic> json) => Scenario(
    id: json['id'] as String,
    stage: json['stage'] as String,
    routes: json['routes'] as String,
    templateText: json['template_text'] as String,
    statEffect: json['stat_effect'] as Map<String, dynamic>,
    weight: json['weight'] as int,
    conditionStat: json['condition_stat'] as String?,
    conditionValue: (json['condition_value'] as int?) ?? 0,
    successText: json['success_text'] as String?,
    failureText: json['failure_text'] as String?,
    successEffect: (json['success_effect'] as Map<String, dynamic>?) ?? {},
    failureEffect: (json['failure_effect'] as Map<String, dynamic>?) ?? {},
    imagePrompt: json['image_prompt'] as String?,
  );
}
