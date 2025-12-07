// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseServiceHash() => r'330c982ac8ee273d70a4f7aeb31e82a3923b866e';

/// See also [supabaseService].
@ProviderFor(supabaseService)
final supabaseServiceProvider = AutoDisposeProvider<SupabaseService>.internal(
  supabaseService,
  name: r'supabaseServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$supabaseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupabaseServiceRef = AutoDisposeProviderRef<SupabaseService>;
String _$partnersHash() => r'dac696433f41db977c970bf5389f7046fbbdb5f6';

/// See also [partners].
@ProviderFor(partners)
final partnersProvider = AutoDisposeFutureProvider<List<Partner>>.internal(
  partners,
  name: r'partnersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$partnersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PartnersRef = AutoDisposeFutureProviderRef<List<Partner>>;
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
String _$partnerNotifierHash() => r'3e0c3541d7e23c4d98dec54de90cac30dfc68859';

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
