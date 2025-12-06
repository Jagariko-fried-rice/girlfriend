// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentAgentHash() => r'24de88a26395f1f50686a932537d40afd1c4e52d';

/// See also [currentAgent].
@ProviderFor(currentAgent)
final currentAgentProvider = AutoDisposeProvider<Agent?>.internal(
  currentAgent,
  name: r'currentAgentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentAgentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentAgentRef = AutoDisposeProviderRef<Agent?>;
String _$canEvolveAgentHash() => r'86c6666ade178b2b951b69ecb0ad503f1b3c2083';

/// See also [canEvolveAgent].
@ProviderFor(canEvolveAgent)
final canEvolveAgentProvider = AutoDisposeProvider<bool>.internal(
  canEvolveAgent,
  name: r'canEvolveAgentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$canEvolveAgentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CanEvolveAgentRef = AutoDisposeProviderRef<bool>;
String _$agentNotifierHash() => r'f7d3969b5f409e0f125a473f5f81a62e22c6ea31';

/// See also [AgentNotifier].
@ProviderFor(AgentNotifier)
final agentNotifierProvider =
    AutoDisposeNotifierProvider<AgentNotifier, Agent?>.internal(
      AgentNotifier.new,
      name: r'agentNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$agentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AgentNotifier = AutoDisposeNotifier<Agent?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
