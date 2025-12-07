// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Memory {
  String get id => throw _privateConstructorUsedError;
  String get partnerId => throw _privateConstructorUsedError;
  String get scenarioId => throw _privateConstructorUsedError;
  String get generatedPrompt => throw _privateConstructorUsedError;
  DateTime get occurredAt => throw _privateConstructorUsedError;

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryCopyWith<Memory> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryCopyWith<$Res> {
  factory $MemoryCopyWith(Memory value, $Res Function(Memory) then) =
      _$MemoryCopyWithImpl<$Res, Memory>;
  @useResult
  $Res call({
    String id,
    String partnerId,
    String scenarioId,
    String generatedPrompt,
    DateTime occurredAt,
  });
}

/// @nodoc
class _$MemoryCopyWithImpl<$Res, $Val extends Memory>
    implements $MemoryCopyWith<$Res> {
  _$MemoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partnerId = null,
    Object? scenarioId = null,
    Object? generatedPrompt = null,
    Object? occurredAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            partnerId:
                null == partnerId
                    ? _value.partnerId
                    : partnerId // ignore: cast_nullable_to_non_nullable
                        as String,
            scenarioId:
                null == scenarioId
                    ? _value.scenarioId
                    : scenarioId // ignore: cast_nullable_to_non_nullable
                        as String,
            generatedPrompt:
                null == generatedPrompt
                    ? _value.generatedPrompt
                    : generatedPrompt // ignore: cast_nullable_to_non_nullable
                        as String,
            occurredAt:
                null == occurredAt
                    ? _value.occurredAt
                    : occurredAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemoryImplCopyWith<$Res> implements $MemoryCopyWith<$Res> {
  factory _$$MemoryImplCopyWith(
    _$MemoryImpl value,
    $Res Function(_$MemoryImpl) then,
  ) = __$$MemoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String partnerId,
    String scenarioId,
    String generatedPrompt,
    DateTime occurredAt,
  });
}

/// @nodoc
class __$$MemoryImplCopyWithImpl<$Res>
    extends _$MemoryCopyWithImpl<$Res, _$MemoryImpl>
    implements _$$MemoryImplCopyWith<$Res> {
  __$$MemoryImplCopyWithImpl(
    _$MemoryImpl _value,
    $Res Function(_$MemoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partnerId = null,
    Object? scenarioId = null,
    Object? generatedPrompt = null,
    Object? occurredAt = null,
  }) {
    return _then(
      _$MemoryImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        partnerId:
            null == partnerId
                ? _value.partnerId
                : partnerId // ignore: cast_nullable_to_non_nullable
                    as String,
        scenarioId:
            null == scenarioId
                ? _value.scenarioId
                : scenarioId // ignore: cast_nullable_to_non_nullable
                    as String,
        generatedPrompt:
            null == generatedPrompt
                ? _value.generatedPrompt
                : generatedPrompt // ignore: cast_nullable_to_non_nullable
                    as String,
        occurredAt:
            null == occurredAt
                ? _value.occurredAt
                : occurredAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$MemoryImpl implements _Memory {
  const _$MemoryImpl({
    required this.id,
    required this.partnerId,
    required this.scenarioId,
    required this.generatedPrompt,
    required this.occurredAt,
  });

  @override
  final String id;
  @override
  final String partnerId;
  @override
  final String scenarioId;
  @override
  final String generatedPrompt;
  @override
  final DateTime occurredAt;

  @override
  String toString() {
    return 'Memory(id: $id, partnerId: $partnerId, scenarioId: $scenarioId, generatedPrompt: $generatedPrompt, occurredAt: $occurredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.scenarioId, scenarioId) ||
                other.scenarioId == scenarioId) &&
            (identical(other.generatedPrompt, generatedPrompt) ||
                other.generatedPrompt == generatedPrompt) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    partnerId,
    scenarioId,
    generatedPrompt,
    occurredAt,
  );

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryImplCopyWith<_$MemoryImpl> get copyWith =>
      __$$MemoryImplCopyWithImpl<_$MemoryImpl>(this, _$identity);
}

abstract class _Memory implements Memory {
  const factory _Memory({
    required final String id,
    required final String partnerId,
    required final String scenarioId,
    required final String generatedPrompt,
    required final DateTime occurredAt,
  }) = _$MemoryImpl;

  @override
  String get id;
  @override
  String get partnerId;
  @override
  String get scenarioId;
  @override
  String get generatedPrompt;
  @override
  DateTime get occurredAt;

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryImplCopyWith<_$MemoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
