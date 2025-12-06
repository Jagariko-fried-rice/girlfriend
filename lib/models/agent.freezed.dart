// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Agent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get generation => throw _privateConstructorUsedError;
  int get scoreTotal => throw _privateConstructorUsedError;
  int get scoreRecent => throw _privateConstructorUsedError;
  String get personalityType =>
      throw _privateConstructorUsedError; // Brave, Calm, Logic, Random
  Map<String, dynamic> get behaviorBias => throw _privateConstructorUsedError;
  String? get partnerId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Agent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgentCopyWith<Agent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentCopyWith<$Res> {
  factory $AgentCopyWith(Agent value, $Res Function(Agent) then) =
      _$AgentCopyWithImpl<$Res, Agent>;
  @useResult
  $Res call({
    String id,
    String name,
    int generation,
    int scoreTotal,
    int scoreRecent,
    String personalityType,
    Map<String, dynamic> behaviorBias,
    String? partnerId,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AgentCopyWithImpl<$Res, $Val extends Agent>
    implements $AgentCopyWith<$Res> {
  _$AgentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Agent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? generation = null,
    Object? scoreTotal = null,
    Object? scoreRecent = null,
    Object? personalityType = null,
    Object? behaviorBias = null,
    Object? partnerId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            generation:
                null == generation
                    ? _value.generation
                    : generation // ignore: cast_nullable_to_non_nullable
                        as int,
            scoreTotal:
                null == scoreTotal
                    ? _value.scoreTotal
                    : scoreTotal // ignore: cast_nullable_to_non_nullable
                        as int,
            scoreRecent:
                null == scoreRecent
                    ? _value.scoreRecent
                    : scoreRecent // ignore: cast_nullable_to_non_nullable
                        as int,
            personalityType:
                null == personalityType
                    ? _value.personalityType
                    : personalityType // ignore: cast_nullable_to_non_nullable
                        as String,
            behaviorBias:
                null == behaviorBias
                    ? _value.behaviorBias
                    : behaviorBias // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>,
            partnerId:
                freezed == partnerId
                    ? _value.partnerId
                    : partnerId // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgentImplCopyWith<$Res> implements $AgentCopyWith<$Res> {
  factory _$$AgentImplCopyWith(
    _$AgentImpl value,
    $Res Function(_$AgentImpl) then,
  ) = __$$AgentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int generation,
    int scoreTotal,
    int scoreRecent,
    String personalityType,
    Map<String, dynamic> behaviorBias,
    String? partnerId,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AgentImplCopyWithImpl<$Res>
    extends _$AgentCopyWithImpl<$Res, _$AgentImpl>
    implements _$$AgentImplCopyWith<$Res> {
  __$$AgentImplCopyWithImpl(
    _$AgentImpl _value,
    $Res Function(_$AgentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Agent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? generation = null,
    Object? scoreTotal = null,
    Object? scoreRecent = null,
    Object? personalityType = null,
    Object? behaviorBias = null,
    Object? partnerId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AgentImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        generation:
            null == generation
                ? _value.generation
                : generation // ignore: cast_nullable_to_non_nullable
                    as int,
        scoreTotal:
            null == scoreTotal
                ? _value.scoreTotal
                : scoreTotal // ignore: cast_nullable_to_non_nullable
                    as int,
        scoreRecent:
            null == scoreRecent
                ? _value.scoreRecent
                : scoreRecent // ignore: cast_nullable_to_non_nullable
                    as int,
        personalityType:
            null == personalityType
                ? _value.personalityType
                : personalityType // ignore: cast_nullable_to_non_nullable
                    as String,
        behaviorBias:
            null == behaviorBias
                ? _value._behaviorBias
                : behaviorBias // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
        partnerId:
            freezed == partnerId
                ? _value.partnerId
                : partnerId // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AgentImpl implements _Agent {
  const _$AgentImpl({
    required this.id,
    required this.name,
    required this.generation,
    required this.scoreTotal,
    required this.scoreRecent,
    required this.personalityType,
    required final Map<String, dynamic> behaviorBias,
    this.partnerId,
    required this.createdAt,
    required this.updatedAt,
  }) : _behaviorBias = behaviorBias;

  @override
  final String id;
  @override
  final String name;
  @override
  final int generation;
  @override
  final int scoreTotal;
  @override
  final int scoreRecent;
  @override
  final String personalityType;
  // Brave, Calm, Logic, Random
  final Map<String, dynamic> _behaviorBias;
  // Brave, Calm, Logic, Random
  @override
  Map<String, dynamic> get behaviorBias {
    if (_behaviorBias is EqualUnmodifiableMapView) return _behaviorBias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_behaviorBias);
  }

  @override
  final String? partnerId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Agent(id: $id, name: $name, generation: $generation, scoreTotal: $scoreTotal, scoreRecent: $scoreRecent, personalityType: $personalityType, behaviorBias: $behaviorBias, partnerId: $partnerId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.scoreTotal, scoreTotal) ||
                other.scoreTotal == scoreTotal) &&
            (identical(other.scoreRecent, scoreRecent) ||
                other.scoreRecent == scoreRecent) &&
            (identical(other.personalityType, personalityType) ||
                other.personalityType == personalityType) &&
            const DeepCollectionEquality().equals(
              other._behaviorBias,
              _behaviorBias,
            ) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    generation,
    scoreTotal,
    scoreRecent,
    personalityType,
    const DeepCollectionEquality().hash(_behaviorBias),
    partnerId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Agent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentImplCopyWith<_$AgentImpl> get copyWith =>
      __$$AgentImplCopyWithImpl<_$AgentImpl>(this, _$identity);
}

abstract class _Agent implements Agent {
  const factory _Agent({
    required final String id,
    required final String name,
    required final int generation,
    required final int scoreTotal,
    required final int scoreRecent,
    required final String personalityType,
    required final Map<String, dynamic> behaviorBias,
    final String? partnerId,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AgentImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  int get generation;
  @override
  int get scoreTotal;
  @override
  int get scoreRecent;
  @override
  String get personalityType; // Brave, Calm, Logic, Random
  @override
  Map<String, dynamic> get behaviorBias;
  @override
  String? get partnerId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Agent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgentImplCopyWith<_$AgentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
