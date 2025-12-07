import 'package:freezed_annotation/freezed_annotation.dart';

part 'girlfriend.freezed.dart';

@freezed
class Girlfriend with _$Girlfriend {
  const factory Girlfriend({
    required String id,
    required String name,
    required String personality, // tsundere, genki, cool, yandere
    required String voice, // soft, energetic, cool, sweet
    required String hairColor, // pink, blue, purple, silver, red, blonde
    required String outfit, // school, casual, formal, fantasy, modern
    required int relationLevel, // 0-100
    required DateTime createdAt,
  }) = _Girlfriend;
}
