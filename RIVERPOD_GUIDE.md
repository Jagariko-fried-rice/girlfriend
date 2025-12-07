# 状態管理アーキテクチャ - Riverpod ガイド

## 概要

このプロジェクトは **Riverpod** を使用した状態管理を採用しています。agent.md で定義されたエージェント・パートナーシステムと連携し、ユーザー認証、ガールフレンド設定、アプリケーションナビゲーションを統合的に管理します。

---

## ディレクトリ構造

```
lib/
├── main.dart                    # アプリケーションのエントリポイント
├── models/                      # Freezed で定義された immutable モデル
│   ├── user.dart               # ユーザー認証情報
│   ├── girlfriend.dart         # ガールフレンド設定
│   ├── agent.dart              # エージェント（agent.md に準拠）
│   ├── partner.dart            # パートナー（agent.md に準拠）
│   └── story_segment.dart      # ストーリーセグメント
├── providers/                   # Riverpod State Management
│   ├── app_state_provider.dart # アプリナビゲーション状態
│   ├── user_provider.dart      # ユーザー認証状態
│   ├── girlfriend_provider.dart# ガールフレンド設定状態
│   ├── agent_provider.dart     # エージェント状態
│   ├── partner_provider.dart   # パートナー状態
│   └── providers.dart          # Barrel export
└── screens/                     # UI層（Riverpod 統合版）
    ├── opening_screen.dart
    ├── login_screen.dart
    ├── girlfriend_setup_screen.dart
    ├── dashboard_screen.dart
    ├── alarm_screen.dart
    └── life_memory_screen.dart
```

---

## モデル定義

### User（ユーザー）

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required int age,
    required String sleepTime,
    required DateTime createdAt,
  }) = _User;
}
```

**用途**: ユーザー認証情報、プロフィール管理

---

### Girlfriend（ガールフレンド）

```dart
@freezed
class Girlfriend with _$Girlfriend {
  const factory Girlfriend({
    required String id,
    required String name,
    required String personality,  // tsundere, genki, cool, yandere
    required String voice,         // soft, energetic, cool, sweet
    required String hairColor,     // pink, blue, purple, silver, red, blonde
    required String outfit,        // school, casual, formal, fantasy, modern
    required int relationLevel,    // 0-100
    required DateTime createdAt,
  }) = _Girlfriend;
}
```

**用途**: AI ガールフレンドのキャラクター設定、関係値管理

---

### Agent（エージェント）

```dart
@freezed
class Agent with _$Agent {
  const factory Agent({
    required String id,
    required String name,
    required int generation,
    required int scoreTotal,
    required int scoreRecent,
    required String personalityType,  // Brave, Calm, Logic, Random
    required Map<String, dynamic> behaviorBias,
    String? partnerId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Agent;
}
```

**用途**: agent.md で定義されたエージェント管理

---

### Partner（パートナー）

```dart
@freezed
class Partner with _$Partner {
  const factory Partner({
    required String id,
    required String name,
    required int stamina,
    required int intelligence,
    required int sense,
    required int relationLevel,   // 0-100 信頼度
    String? assignedAgentId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Partner;
}
```

**用途**: agent.md で定義されたパートナー管理

---

## プロバイダー使用ガイド

### 1. アプリナビゲーション管理

```dart
// UI で読み込み
final stage = ref.watch(appStateNotifierProvider);

// ナビゲーション操作
ref.read(appStateNotifierProvider.notifier).moveToLogin();
ref.read(appStateNotifierProvider.notifier).moveToSetup();
ref.read(appStateNotifierProvider.notifier).moveToHome();
```

---

### 2. ユーザー認証管理

```dart
// ユーザー設定
final user = User(
  id: '123',
  name: 'John',
  email: 'john@example.com',
  age: 25,
  sleepTime: '23:00',
  createdAt: DateTime.now(),
);
ref.read(userNotifierProvider.notifier).setUser(user);

// ユーザー取得
final currentUser = ref.watch(userNotifierProvider);

// ログイン状態確認
final isLoggedIn = ref.watch(isLoggedInProvider);

// ログアウト
ref.read(userNotifierProvider.notifier).clearUser();
```

---

### 3. ガールフレンド管理

```dart
// ガールフレンド設定
final girlfriend = Girlfriend(
  id: '456',
  name: 'Sakura',
  personality: 'tsundere',
  voice: 'soft',
  hairColor: 'pink',
  outfit: 'school',
  relationLevel: 50,
  createdAt: DateTime.now(),
);
ref.read(girlfriendNotifierProvider.notifier).setGirlfriend(girlfriend);

// 関係値更新
ref.read(girlfriendNotifierProvider.notifier).updateRelationLevel(75);

// 取得
final gf = ref.watch(girlfriendNotifierProvider);
```

---

### 4. エージェント管理

```dart
// エージェント設定
final agent = Agent(
  id: 'agent_1',
  name: 'BraveAgent',
  generation: 1,
  scoreTotal: 500,
  scoreRecent: 100,
  personalityType: 'Brave',
  behaviorBias: {'risk': 0.7, 'exploration': 0.8},
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
ref.read(agentNotifierProvider.notifier).setAgent(agent);

// スコア更新
ref.read(agentNotifierProvider.notifier).updateScore(150);

// 進化判定
if (ref.watch(canEvolveAgentProvider)) {
  ref.read(agentNotifierProvider.notifier).evolve();
}

// 取得
final currentAgent = ref.watch(agentNotifierProvider);
```

---

### 5. パートナー管理

```dart
// パートナー設定
final partner = Partner(
  id: 'partner_1',
  name: 'Guide',
  stamina: 80,
  intelligence: 90,
  sense: 85,
  relationLevel: 70,
  assignedAgentId: 'agent_1',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
ref.read(partnerNotifierProvider.notifier).setPartner(partner);

// ステータス更新
ref.read(partnerNotifierProvider.notifier)
    .updateStats(stamina: 85, intelligence: 92);

// 関係値更新
ref.read(partnerNotifierProvider.notifier).updateRelationLevel(80);

// 取得
final partner = ref.watch(partnerNotifierProvider);
```

---

## ConsumerWidget での使用例

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 状態監視
    final user = ref.watch(userNotifierProvider);
    final girlfriend = ref.watch(girlfriendNotifierProvider);
    
    // 状態変更
    return ElevatedButton(
      onPressed: () {
        ref.read(appStateNotifierProvider.notifier).moveToHome();
      },
      child: Text('${user?.name ?? 'Guest'} with ${girlfriend?.name}'),
    );
  }
}
```

---

## ConsumerStatefulWidget での使用例

```dart
class MyScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends ConsumerState<MyScreen> {
  @override
  void initState() {
    super.initState();
    // 初期化時に状態を読み込み
    final agent = ref.read(agentNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final agent = ref.watch(agentNotifierProvider);
    
    return Text('Agent: ${agent?.name}');
  }
}
```

---

## ベストプラクティス

### 1. **読み込み（watch）と書き込み（read）の使い分け**

```dart
// watch: UI 再構築時に監視する状態変更
final state = ref.watch(userNotifierProvider);

// read: 一度だけ取得するか、イベントハンドラ内で使用
ref.read(userNotifierProvider.notifier).setUser(user);
```

### 2. **Selector を使用した最適化**

UI の一部分だけが必要な場合は、selector を使って不要な再構築を防ぐ：

```dart
final userName = ref.watch(
  userNotifierProvider.select((user) => user?.name ?? ''),
);
```

### 3. **error handling と loading state**

```dart
// AsyncValue を使用する非同期プロバイダーの場合
final data = ref.watch(asyncDataProvider);
data.when(
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
  data: (data) => Text('Data: $data'),
);
```

### 4. **キャッシング と無効化**

```dart
// キャッシュを無効化して再取得
ref.refresh(userNotifierProvider);

// または全キャッシュをクリア
ref.invalidate(userNotifierProvider);
```

---

## 今後の拡張計画

1. **非同期プロバイダー追加**: API 呼び出しなどで AsyncValue を使用
2. **Family パラメータ**: 複数のエージェント・パートナーを同時管理
3. **StateNotifierProvider 深化**: より複雑なビジネスロジック実装
4. **Database 連携**: Hive や Firebase との統合
5. **テスト**: Riverpod の ProviderContainer を使用したユニットテスト

---

## 参考資料

- [Riverpod 公式ドキュメント](https://riverpod.dev/)
- [Freezed で不変クラスを生成](https://pub.dev/packages/freezed)
- [agent.md - エージェント・パートナー仕様](./agent.md)

