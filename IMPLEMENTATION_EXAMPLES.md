# 実装例

## 1. エージェント・パートナーシステムの初期化

```dart
// ユーザーと同時にエージェント・パートナーを作成

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // エージェント作成
        final agent = Agent(
          id: 'agent_001',
          name: 'AdventureAgent',
          generation: 1,
          scoreTotal: 0,
          scoreRecent: 0,
          personalityType: 'Brave',
          behaviorBias: {
            'risk_preference': 0.7,
            'exploration': 0.8,
            'learning_rate': 0.6,
          },
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        ref.read(agentNotifierProvider.notifier).setAgent(agent);

        // パートナー作成
        final partner = Partner(
          id: 'partner_001',
          name: 'Guide',
          stamina: 80,
          intelligence: 90,
          sense: 85,
          relationLevel: 50,
          assignedAgentId: 'agent_001',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        ref.read(partnerNotifierProvider.notifier).setPartner(partner);
      },
      child: Text('Initialize Agent & Partner'),
    );
  }
}
```

---

## 2. ミッション実行結果に基づくスコア更新

```dart
void executeMission(WidgetRef ref) {
  final agent = ref.read(agentNotifierProvider);
  if (agent == null) return;

  // ミッション実行（例：報酬獲得 100 スコア）
  final missionReward = 150;
  
  // エージェントのスコアを更新
  ref.read(agentNotifierProvider.notifier).updateScore(missionReward);

  // パートナーの能力に応じてボーナス適用
  final partner = ref.read(partnerNotifierProvider);
  if (partner != null && partner.relationLevel > 70) {
    final bonus = (missionReward * 0.2).toInt(); // 20% ボーナス
    ref.read(agentNotifierProvider.notifier).updateScore(bonus);
  }

  // 進化判定
  if (ref.read(canEvolveAgentProvider)) {
    ref.read(agentNotifierProvider.notifier).evolve();
    debugPrint('Agent evolved to generation ${agent.generation + 1}');
  }
}
```

---

## 3. UI での状態監視と再構築

```dart
class AgentInfoWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agent = ref.watch(agentNotifierProvider);
    final canEvolve = ref.watch(canEvolveAgentProvider);
    final partner = ref.watch(partnerNotifierProvider);

    if (agent == null) {
      return Text('No Agent');
    }

    return Column(
      children: [
        Text('${agent.name} (Generation ${agent.generation})'),
        Text('Score: ${agent.scoreTotal} / Recent: ${agent.scoreRecent}'),
        Text('Personality: ${agent.personalityType}'),
        if (partner != null) ...[
          Divider(),
          Text('Partner: ${partner.name}'),
          Text('Relation: ${partner.relationLevel}/100'),
          LinearProgressIndicator(
            value: partner.relationLevel / 100,
            minHeight: 8,
          ),
        ],
        if (canEvolve)
          ElevatedButton(
            onPressed: () {
              ref.read(agentNotifierProvider.notifier).evolve();
            },
            child: Text('Evolve!'),
          ),
      ],
    );
  }
}
```

---

## 4. 関係値に基づいた行動決定

```dart
class BehaviorDecisionService {
  static Map<String, dynamic> decideBehavior(
    Agent agent,
    Partner? partner,
  ) {
    // パートナーの influence を反映
    var bias = agent.behaviorBias;
    
    if (partner != null) {
      // 関係値が高いほどパートナーの指示に従いやすくなる
      final partnerInfluence = partner.relationLevel / 100.0;
      
      // インテリジェンスが高いほどリスク軽減
      final intelligenceBonus = partner.intelligence / 100.0;
      
      bias = {
        ...bias,
        'risk_preference': 
          (bias['risk_preference'] ?? 0.5) * (1 - intelligenceBonus * 0.3),
        'partner_influence': partnerInfluence,
      };
    }

    return bias;
  }
}

// 使用例
class MissionPlanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agent = ref.watch(agentNotifierProvider);
    final partner = ref.watch(partnerNotifierProvider);

    if (agent == null) return SizedBox.shrink();

    final behavior = BehaviorDecisionService.decideBehavior(agent, partner);

    return Card(
      child: Column(
        children: [
          Text('Mission Behavior Profile'),
          ...behavior.entries.map((e) => 
            Text('${e.key}: ${(e.value is double ? (e.value * 100).toStringAsFixed(1) : e.value)}')
          ),
        ],
      ),
    );
  }
}
```

---

## 5. ガールフレンド関係値の更新

```dart
class InteractionHandler {
  static void handlePositiveInteraction(WidgetRef ref) {
    final girlfriend = ref.read(girlfriendNotifierProvider);
    if (girlfriend == null) return;

    // 関係値を 5 増加
    var newLevel = girlfriend.relationLevel + 5;
    if (newLevel > 100) newLevel = 100;

    ref.read(girlfriendNotifierProvider.notifier)
        .updateRelationLevel(newLevel);

    // パートナーの relation_level も連動
    final partner = ref.read(partnerNotifierProvider);
    if (partner != null) {
      var partnerNewLevel = partner.relationLevel + 3;
      if (partnerNewLevel > 100) partnerNewLevel = 100;
      ref.read(partnerNotifierProvider.notifier)
          .updateRelationLevel(partnerNewLevel);
    }
  }

  static void handleNegativeInteraction(WidgetRef ref) {
    final girlfriend = ref.read(girlfriendNotifierProvider);
    if (girlfriend == null) return;

    var newLevel = girlfriend.relationLevel - 10;
    if (newLevel < 0) newLevel = 0;

    ref.read(girlfriendNotifierProvider.notifier)
        .updateRelationLevel(newLevel);
  }
}
```

---

## 6. 永続化（Future: Firebase/Hive 連携）

```dart
// 将来的な非同期プロバイダーの例

@riverpod
Future<Agent> loadAgentFromFirebase(LoadAgentFromFirebaseRef ref, String agentId) async {
  // Firebase から Agent を取得
  final doc = await FirebaseFirestore.instance
      .collection('agents')
      .doc(agentId)
      .get();

  final data = doc.data() as Map<String, dynamic>;
  return Agent.fromJson(data);
}

@riverpod
Future<void> saveAgentToFirebase(SaveAgentToFirebaseRef ref, Agent agent) async {
  await FirebaseFirestore.instance
      .collection('agents')
      .doc(agent.id)
      .set(agent.toJson());
}
```

---

## 7. ストーリーセグメントと関連付け

```dart
class LifeMemoryManager {
  static void addMemory(
    WidgetRef ref,
    String title,
    String content,
    int age,
  ) {
    // ガールフレンドの関係値に応じてメモリを彩色
    final girlfriend = ref.read(girlfriendNotifierProvider);
    final emotionColor = girlfriend?.relationLevel ?? 0 > 70
        ? Colors.red
        : Colors.blue;

    final storySegment = StorySegment(
      age: age,
      title: title,
      description: content,
      imageEmoji: '💭',
    );

    // Store in state management or DB
    debugPrint('Memory added: $title at age $age');
  }
}
```

---

## まとめ

Riverpod による状態管理で以下が実現できます：

1. **一元管理**: ユーザー、ガールフレンド、エージェント、パートナーを統一的に管理
2. **リアクティブ UI**: 状態変更時に自動的に UI が更新される
3. **スケーラビリティ**: agent.md の複雑なロジックを整理された状態で実装
4. **テスト容易性**: 非依存性の逆転により、ユニットテストが簡単
5. **拡張性**: 非同期プロバイダー追加により、API 連携やDB 永続化が容易

