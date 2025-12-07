import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String uid,
    required String auth0Sub,
    required String displayName,
    required String email,
    required DateTime createdAt,
  }) = _User;

  /// Convert from Supabase JSON
  factory User.fromSupabase(Map<String, dynamic> json) => User(
    uid: json['uid'] as String,
    auth0Sub: json['auth0_sub'] as String,
    displayName: json['display_name'] as String,
    email: json['email'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  /// Convert to Supabase JSON
  static Map<String, dynamic> toSupabase(User user) => {
    'uid': user.uid,
    'auth0_sub': user.auth0Sub,
    'display_name': user.displayName,
    'email': user.email,
    'created_at': user.createdAt.toIso8601String(),
  };
}
