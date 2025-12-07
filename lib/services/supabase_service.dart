import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../models/user.dart';
import '../models/partner.dart';
import '../models/scenario.dart';
import '../models/memory.dart';
import '../models/sleep_log.dart';

/// Service class for Supabase data operations
class SupabaseService {
  final SupabaseClient _client;

  SupabaseService() : _client = Supabase.instance.client;

  /// Get current Supabase client
  SupabaseClient get client => _client;

  // ==================== Users ====================

  /// Fetch all users
  Future<List<User>> fetchUsers() async {
    final response = await _client.from('users').select();
    return (response as List).map((json) => User.fromSupabase(json)).toList();
  }

  /// Fetch user by UID
  Future<User?> fetchUserByUid(String uid) async {
    final response = await _client.from('users').select().eq('uid', uid).maybeSingle();
    return response != null ? User.fromSupabase(response) : null;
  }

  // ==================== Partners ====================

  /// Fetch all partners
  Future<List<Partner>> fetchPartners() async {
    final response = await _client.from('partners').select();
    return (response as List).map((json) => Partner.fromSupabase(json)).toList();
  }

  /// Fetch partners by user ID
  Future<List<Partner>> fetchPartnersByUserId(String userId) async {
    final response = await _client.from('partners').select().eq('user_id', userId);
    return (response as List).map((json) => Partner.fromSupabase(json)).toList();
  }

  /// Fetch partner by ID
  Future<Partner?> fetchPartnerById(String id) async {
    final response = await _client.from('partners').select().eq('id', id).maybeSingle();
    return response != null ? Partner.fromSupabase(response) : null;
  }

  /// Create a new partner
  Future<Partner> createPartner(Partner partner) async {
    final response = await _client
        .from('partners')
        .insert(Partner.toSupabase(partner))
        .select()
        .single();
    return Partner.fromSupabase(response);
  }

  /// Update partner stats
  Future<Partner> updatePartnerStats(String id, {int? stamina, int? intelligence, int? sense}) async {
    final updates = <String, dynamic>{};
    if (stamina != null) updates['stamina'] = stamina;
    if (intelligence != null) updates['intelligence'] = intelligence;
    if (sense != null) updates['sense'] = sense;
    
    final response = await _client
        .from('partners')
        .update(updates)
        .eq('id', id)
        .select()
        .single();
    return Partner.fromSupabase(response);
  }

  // ==================== Scenarios ====================

  /// Fetch all scenarios
  Future<List<Scenario>> fetchScenarios() async {
    final response = await _client.from('scenarios').select();
    return (response as List).map((json) => Scenario.fromSupabase(json)).toList();
  }

  /// Fetch scenarios by stage
  Future<List<Scenario>> fetchScenariosByStage(String stage) async {
    final response = await _client.from('scenarios').select().eq('stage', stage);
    return (response as List).map((json) => Scenario.fromSupabase(json)).toList();
  }

  // ==================== Memories ====================

  /// Fetch memories by partner ID
  Future<List<Memory>> fetchMemoriesByPartnerId(String partnerId) async {
    final response = await _client.from('memories').select().eq('partner_id', partnerId);
    return (response as List).map((json) => Memory.fromSupabase(json)).toList();
  }

  /// Create a new memory
  Future<Memory> createMemory(Memory memory) async {
    final response = await _client
        .from('memories')
        .insert(Memory.toSupabase(memory))
        .select()
        .single();
    return Memory.fromSupabase(response);
  }

  // ==================== Sleep Logs ====================

  /// Fetch sleep logs by user ID
  Future<List<SleepLog>> fetchSleepLogsByUserId(String userId) async {
    final response = await _client.from('sleep_logs').select().eq('user_id', userId);
    return (response as List).map((json) => SleepLog.fromSupabase(json)).toList();
  }

  /// Create a new sleep log
  Future<SleepLog> createSleepLog(SleepLog log) async {
    final response = await _client
        .from('sleep_logs')
        .insert(SleepLog.toSupabase(log))
        .select()
        .single();
    return SleepLog.fromSupabase(response);
  }

  /// Update sleep log with wake time
  Future<SleepLog> updateSleepLogWakeTime(String id, DateTime wakeAt, int sleepMinutes) async {
    final response = await _client
        .from('sleep_logs')
        .update({
          'wake_at': wakeAt.toIso8601String(),
          'sleep_minutes': sleepMinutes,
        })
        .eq('id', id)
        .select()
        .single();
    return SleepLog.fromSupabase(response);
  }
}
