# AGENTS.md

## 1. 概要

本ドキュメントは、エージェント管理システムにおける **Agent（以下、エージェント）および Partner（以下、パートナー）** の仕様、振る舞い、データモデル、DB マッピングを定義するものである。エージェントの生成、評価、進化に関するルール、ならびにパートナーとの関係性、行動特性の影響範囲を明確化することを目的とする。

---

## 2. Agent 仕様

### 2.1 Agent の役割

エージェントは、行動決定アルゴリズムを持ち、ミッション実行や報酬獲得を通じて能力評価（Score）を蓄積する主体である。各エージェントは個別の特性値と行動履歴を持つ。

### 2.2 Agent 特性一覧

| 項目                   | 説明                                        |
| -------------------- | ----------------------------------------- |
| **agent_id**         | エージェント固有 ID                               |
| **name**             | 表示名                                       |
| **generation**       | 世代。初期値は 1。進化により増加する。                      |
| **score_total**      | これまでに蓄積した総合スコア                            |
| **score_recent**     | 直近の活動期における評価スコア                           |
| **personality_type** | 性格タイプ（例：Brave / Calm / Logic / Random など） |
| **behavior_bias**    | 行動傾向（リスク選好・安定志向・探索型などの重み付け）               |
| **partner_id**       | 担当パートナー ID（任意）                            |

### 2.3 Agent の行動決定

エージェントは以下の要素を組み合わせて行動を選択する：

* 性格タイプ
* 行動バイアス
* 過去の成功・失敗実績
* パートナーの指示（存在する場合）

### 2.4 エージェントの評価（Scoring）

ミッション結果より以下を総合して Score を算出する：

* 成果達成度
* リスク管理（大失敗の回避など）
* 探索・改善行動の有無
* 成果の安定性

スコアは `score_recent` に反映された後、任意タイミングで `score_total` に統合される。

---

## 3. Partner 仕様

### 3.1 Partner の役割

パートナーはエージェントをサポートし、指示、補正、アドバイスを行うヒューマンライクな存在である。ステータスによって指示の質やエージェントの行動傾向に影響を与える。

### 3.2 Partner 特性一覧

| 項目                    | 説明                |
| --------------------- | ----------------- |
| **partner_id**        | パートナー固有 ID        |
| **name**              | 表示名               |
| **stamina**           | 活動持続力（更新仕様は未定）    |
| **intelligence**      | 判断力（更新仕様は未定）      |
| **sense**             | 直感・ひらめき（更新仕様は未定）  |
| **relation_level**    | エージェントとの関係強度（信頼度） |
| **assigned_agent_id** | 担当エージェント ID       |

### 3.3 Partner のステータス更新

* 各ステータス（stamina / intelligence / sense）の更新方式は現時点では **未定** とする。
* 方針案（参考・未確定）

  * 継続サポートによる緩やかな成長
  * ミッション成功時のボーナス増加
  * 関係値（relation_level）による相互強化 等

---

## 4. Agent ↔ Partner 関係仕様

### 4.1 関係モデル

* エージェント 1 : パートナー 1 の **一対一** を基本とする。
* 将来的に 1:n, n:1, n:n を許容する拡張も想定しているが、現時点では採用しない。

### 4.2 関係の影響

| 項目                 | 影響内容                                 |
| ------------------ | ------------------------------------ |
| **relation_level** | 高いほど、パートナー指示がエージェントの行動決定に反映されやすい     |
| **partner_stats**  | パートナーの能力に応じてエージェントのスコア期待値や探索行動に補正が入る |

---

## 5. Agent 進化（Evolution）

### 5.1 概要

エージェントは一定条件を満たした場合、世代が進み（generation++）、行動傾向・性格タイプ・特性値の再設定が行われる。

### 5.2 進化条件

* score_recent が所定の閾値を超過
* 一定期間の安定的成長
* バッドイベント（大失敗）を一定回避

### 5.3 進化処理

* generation を +1
* 行動戦略モデルの一部を再学習
* personality_type の変化（確率的）
* behavior_bias の調整

---

## 6. データモデル

### 6.1 ER 図に準じた定義（テキスト）

```
Agent (1) ---- (1) Partner
```

ただし、いずれも null 許容の片方向参照が可能。

### 6.2 Agent テーブル

| カラム名             | 型    | 説明                 |
| ---------------- | ---- | ------------------ |
| agent_id         | PK   | 整数または UUID         |
| name             | TEXT | 名前                 |
| generation       | INT  | 世代                 |
| score_total      | INT  | 総合スコア              |
| score_recent     | INT  | 直近スコア              |
| personality_type | TEXT | 性格タイプ              |
| behavior_bias    | JSON | 行動傾向パラメータ          |
| partner_id       | FK   | Partner.partner_id |

### 6.3 Partner テーブル

| カラム名              | 型    | 説明             |
| ----------------- | ---- | -------------- |
| partner_id        | PK   | 整数または UUID     |
| name              | TEXT | 名前             |
| stamina           | INT  | ステータス（更新未定）    |
| intelligence      | INT  | ステータス（更新未定）    |
| sense             | INT  | ステータス（更新未定）    |
| relation_level    | INT  | 信頼値            |
| assigned_agent_id | FK   | Agent.agent_id |

---

## 7. Agent ↔ DB マッピング表

### 7.1 Agent マッピング

| Agent 属性         | DB カラム           |
| ---------------- | ---------------- |
| agent_id         | agent_id         |
| name             | name             |
| generation       | generation       |
| score_total      | score_total      |
| score_recent     | score_recent     |
| personality_type | personality_type |
| behavior_bias    | behavior_bias    |
| partner_id       | partner_id       |

### 7.2 Partner マッピング

| Partner 属性        | DB カラム            |
| ----------------- | ----------------- |
| partner_id        | partner_id        |
| name              | name              |
| stamina           | stamina           |
| intelligence      | intelligence      |
| sense             | sense             |
| relation_level    | relation_level    |
| assigned_agent_id | assigned_agent_id |

---

## 8. 今後の課題

* パートナーステータスの成長ロジック設計
* エージェントの失敗時学習モデルの詳細化
* 世代進化アルゴリズムのパラメータチューニング
* Agent-Partner 関係の n:n への拡張検討

---
