import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_log.freezed.dart';

@freezed
class SleepLog with _$SleepLog {
  const factory SleepLog({
    required String id,
    required String userId,
    required String partnerId,
    required DateTime sleptAt,
    DateTime? wakeAt,
    int? sleepMinutes,
  }) = _SleepLog;

  factory SleepLog.fromSupabase(Map<String, dynamic> json) => SleepLog(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    partnerId: json['partner_id'] as String,
    sleptAt: DateTime.parse(json['slept_at'] as String),
    wakeAt: json['wake_at'] != null ? DateTime.parse(json['wake_at'] as String) : null,
    sleepMinutes: json['sleep_minutes'] as int?,
  );

  static Map<String, dynamic> toSupabase(SleepLog log) => {
    'id': log.id,
    'user_id': log.userId,
    'partner_id': log.partnerId,
    'slept_at': log.sleptAt.toIso8601String(),
    'wake_at': log.wakeAt?.toIso8601String(),
    'sleep_minutes': log.sleepMinutes,
  };
}
