// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentPartnerHash() => r'e5bab2d3e0e944aecde03893c8bc52023110df08';

/// See also [currentPartner].
@ProviderFor(currentPartner)
final currentPartnerProvider = AutoDisposeProvider<Partner?>.internal(
  currentPartner,
  name: r'currentPartnerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentPartnerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentPartnerRef = AutoDisposeProviderRef<Partner?>;
String _$partnerNotifierHash() => r'd6d25ef02b481f1ecc073850c96933a053099c8d';

/// See also [PartnerNotifier].
@ProviderFor(PartnerNotifier)
final partnerNotifierProvider =
    AutoDisposeNotifierProvider<PartnerNotifier, Partner?>.internal(
      PartnerNotifier.new,
      name: r'partnerNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$partnerNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PartnerNotifier = AutoDisposeNotifier<Partner?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
