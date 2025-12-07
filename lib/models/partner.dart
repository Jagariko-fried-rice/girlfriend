import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner.freezed.dart';

@freezed
class Partner with _$Partner {
  const factory Partner({
    required String id,
    required String userId,
    required String name,
    required String personality,
    required String hairColor,
    required String voiceType,
    required String currentStage,
    required int stamina,
    required int intelligence,
    required int sense,
  }) = _Partner;

  /// Convert from Supabase JSON
  factory Partner.fromSupabase(Map<String, dynamic> json) => Partner(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    personality: json['personality'] as String,
    hairColor: json['hair_color'] as String,
    voiceType: json['voice_type'] as String,
    currentStage: json['current_stage'] as String,
    stamina: json['stamina'] as int,
    intelligence: json['intelligence'] as int,
    sense: json['sense'] as int,
  );

  /// Convert to Supabase JSON
  static Map<String, dynamic> toSupabase(Partner partner) => {
    'id': partner.id,
    'user_id': partner.userId,
    'name': partner.name,
    'personality': partner.personality,
    'hair_color': partner.hairColor,
    'voice_type': partner.voiceType,
    'current_stage': partner.currentStage,
    'stamina': partner.stamina,
    'intelligence': partner.intelligence,
    'sense': partner.sense,
  };
}
