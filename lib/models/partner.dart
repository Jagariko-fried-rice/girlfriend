import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner.freezed.dart';

@freezed
class Partner with _$Partner {
  const factory Partner({
    required String id,
    required String name,
    required int stamina,
    required int intelligence,
    required int sense,
    required int relationLevel, // 0-100 信頼度
    String? assignedAgentId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Partner;
}
