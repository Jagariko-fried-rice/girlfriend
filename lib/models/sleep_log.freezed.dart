// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SleepLog {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get partnerId => throw _privateConstructorUsedError;
  DateTime get sleptAt => throw _privateConstructorUsedError;
  DateTime? get wakeAt => throw _privateConstructorUsedError;
  int? get sleepMinutes => throw _privateConstructorUsedError;

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepLogCopyWith<SleepLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepLogCopyWith<$Res> {
  factory $SleepLogCopyWith(SleepLog value, $Res Function(SleepLog) then) =
      _$SleepLogCopyWithImpl<$Res, SleepLog>;
  @useResult
  $Res call({
    String id,
    String userId,
    String partnerId,
    DateTime sleptAt,
    DateTime? wakeAt,
    int? sleepMinutes,
  });
}

/// @nodoc
class _$SleepLogCopyWithImpl<$Res, $Val extends SleepLog>
    implements $SleepLogCopyWith<$Res> {
  _$SleepLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? partnerId = null,
    Object? sleptAt = null,
    Object? wakeAt = freezed,
    Object? sleepMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            partnerId:
                null == partnerId
                    ? _value.partnerId
                    : partnerId // ignore: cast_nullable_to_non_nullable
                        as String,
            sleptAt:
                null == sleptAt
                    ? _value.sleptAt
                    : sleptAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            wakeAt:
                freezed == wakeAt
                    ? _value.wakeAt
                    : wakeAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            sleepMinutes:
                freezed == sleepMinutes
                    ? _value.sleepMinutes
                    : sleepMinutes // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SleepLogImplCopyWith<$Res>
    implements $SleepLogCopyWith<$Res> {
  factory _$$SleepLogImplCopyWith(
    _$SleepLogImpl value,
    $Res Function(_$SleepLogImpl) then,
  ) = __$$SleepLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String partnerId,
    DateTime sleptAt,
    DateTime? wakeAt,
    int? sleepMinutes,
  });
}

/// @nodoc
class __$$SleepLogImplCopyWithImpl<$Res>
    extends _$SleepLogCopyWithImpl<$Res, _$SleepLogImpl>
    implements _$$SleepLogImplCopyWith<$Res> {
  __$$SleepLogImplCopyWithImpl(
    _$SleepLogImpl _value,
    $Res Function(_$SleepLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? partnerId = null,
    Object? sleptAt = null,
    Object? wakeAt = freezed,
    Object? sleepMinutes = freezed,
  }) {
    return _then(
      _$SleepLogImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        partnerId:
            null == partnerId
                ? _value.partnerId
                : partnerId // ignore: cast_nullable_to_non_nullable
                    as String,
        sleptAt:
            null == sleptAt
                ? _value.sleptAt
                : sleptAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        wakeAt:
            freezed == wakeAt
                ? _value.wakeAt
                : wakeAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        sleepMinutes:
            freezed == sleepMinutes
                ? _value.sleepMinutes
                : sleepMinutes // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$SleepLogImpl implements _SleepLog {
  const _$SleepLogImpl({
    required this.id,
    required this.userId,
    required this.partnerId,
    required this.sleptAt,
    this.wakeAt,
    this.sleepMinutes,
  });

  @override
  final String id;
  @override
  final String userId;
  @override
  final String partnerId;
  @override
  final DateTime sleptAt;
  @override
  final DateTime? wakeAt;
  @override
  final int? sleepMinutes;

  @override
  String toString() {
    return 'SleepLog(id: $id, userId: $userId, partnerId: $partnerId, sleptAt: $sleptAt, wakeAt: $wakeAt, sleepMinutes: $sleepMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.sleptAt, sleptAt) || other.sleptAt == sleptAt) &&
            (identical(other.wakeAt, wakeAt) || other.wakeAt == wakeAt) &&
            (identical(other.sleepMinutes, sleepMinutes) ||
                other.sleepMinutes == sleepMinutes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    partnerId,
    sleptAt,
    wakeAt,
    sleepMinutes,
  );

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepLogImplCopyWith<_$SleepLogImpl> get copyWith =>
      __$$SleepLogImplCopyWithImpl<_$SleepLogImpl>(this, _$identity);
}

abstract class _SleepLog implements SleepLog {
  const factory _SleepLog({
    required final String id,
    required final String userId,
    required final String partnerId,
    required final DateTime sleptAt,
    final DateTime? wakeAt,
    final int? sleepMinutes,
  }) = _$SleepLogImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get partnerId;
  @override
  DateTime get sleptAt;
  @override
  DateTime? get wakeAt;
  @override
  int? get sleepMinutes;

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepLogImplCopyWith<_$SleepLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
