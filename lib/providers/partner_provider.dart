import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/partner.dart';

part 'partner_provider.g.dart';

// パートナー管理
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
