import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/partner.dart';
import '../services/supabase_service.dart';

part 'partner_provider.g.dart';

// Supabaseサービスプロバイダー
@riverpod
SupabaseService supabaseService(SupabaseServiceRef ref) {
  return SupabaseService();
}

// パートナー一覧取得（DBから）
@riverpod
Future<List<Partner>> partners(PartnersRef ref) async {
  final service = ref.watch(supabaseServiceProvider);
  print('DEBUG: Fetching partners from Supabase...');
  try {
    final partners = await service.fetchPartners();
    print('DEBUG: Fetched ${partners.length} partners');
    for (var p in partners) {
      print('DEBUG: Partner: ${p.name}');
    }
    return partners;
  } catch (e) {
    print('DEBUG: Error fetching partners: $e');
    rethrow;
  }
}

// パートナー管理（選択されたパートナー）
@riverpod
class PartnerNotifier extends _$PartnerNotifier {
  @override
  Partner? build() => null;

  void setPartner(Partner partner) {
    state = partner;
  }

  void updateStats({int? stamina, int? intelligence, int? sense}) {
    if (state != null) {
      state = state!.copyWith(
        stamina: stamina ?? state!.stamina,
        intelligence: intelligence ?? state!.intelligence,
        sense: sense ?? state!.sense,
      );
    }
  }

  void clearPartner() {
    state = null;
  }

  bool get hasPartner => state != null;
}

// 現在のパートナー取得
@riverpod
Partner? currentPartner(CurrentPartnerRef ref) {
  return ref.watch(partnerNotifierProvider);
}
