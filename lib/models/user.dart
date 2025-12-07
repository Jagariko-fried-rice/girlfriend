import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required int age,
    required String sleepTime,
    required DateTime createdAt,
  }) = _User;
}
