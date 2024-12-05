# Snowflake 勉強メモ

## ■ 基本

### **1. Snowflake とは？**

- **データウェアハウス (DWH)**:
  データを保存し、分析するための専用データベース。
- **用途**:
  一般的な Web アプリケーションのバックエンド用途ではなく、データ分析を目的とした DWH。
- **クラウド型**:
  - AWS、Azure、GCP 上で動作。
  - オンプレミスには非対応。
- **管理の簡素化**:
  - ハードウェアやインフラの管理不要。
  - Snowflake が全面的に管理を行う。

### **2. Snowflake の特徴**

- **SaaS 型サービス**:
  - クラウド上で提供されるため、ユーザーがインフラを意識する必要がない。
- **従量課金制**:
  - 使用した分だけ支払いが発生。
- **セキュリティ**:
  - 高いセキュリティ基準を持つが、詳細は省略。
- **エディション選択**:
  - 5 種類のエディション（利用プラン）が用意されており、ニーズに応じて選択可能。

### **3. 操作体験**

- **GUI 操作**:
  - ブラウザベースの GUI で直感的に操作が可能。
  - データベースの作成や管理が容易。
- **SQL サポート**:
  - 標準的な SQL クエリを実行可能。
  - 内部 GUI や外部ツールから SQL を実行可能。

---

### **4. 重要なポイントの整理**

- **Snowflake はクラウド DWH のリーダー的存在**。
  - 従来のオンプレミス DWH に比べ、柔軟性や拡張性、管理負荷軽減に優れている。
- **初心者向け設計**:
  - GUI を中心に設計されており、プログラミングスキルが少なくても利用可能。
- **導入の手軽さ**:
  - インフラ準備が不要で、アカウント発行後すぐに利用可能。

---

---

## ■Snowflake の真価とユースケース

Snowflake は DWH の機能だけを持つサービスではない。

### **1. Snowflake の特長的な 5 つの機能**

Snowflake はデータウェアハウス以外に以下の 5 つの重要な機能を持つ。

#### **(1) データパイプライン**

- **定義**: 自動化されたデータ処理フローを実現する機能。
- **主な構成要素**:
  1. **Snowpipe**: ステージにアップロードされた新しいファイルを自動で検知・ロード。
  2. **Streams**: ステージングテーブル内の変更履歴をキャプチャ。
  3. **Tasks**: SQL ステートメントをスケジュール実行し、データ変換を行う。
- **メリット**:
  - サーバーレスでインフラ管理不要。
  - 初期コストが発生しない。
  - リアルタイムデータ分析に対応可能。

#### **(2) データレイク**

- **定義**: 生データを一元的に保存するためのリポジトリ。
- **特長**:
  - 構造化・半構造化データ（JSON や XML など）に対応。
  - 公共クラウドストレージ（例：Amazon S3）との連携が容易。
  - SQL で直接データ操作可能。
- **ユースケース**:
  - IoT デバイスから大量に生成されるセンサーデータの自動処理。

#### **(3) データサイエンス**

- **Snowflake の役割**:
  - Snowflake 自身には ML 機能はないが、Amazon SageMaker や DataRobot などの ML ツールと統合可能。
  - Snowflake 内のデータを直接これらのツールに渡してモデルを作成・運用できる。
- **具体例**:
  - SageMaker を用いた機械学習モデルのトレーニングと結果の SQL 関数化。
  - DataRobot を活用した GUI ベースでのモデル構築と統合。

#### **(4) データ共有**

Snowflake は、複数組織間でのリアルタイムなデータ共有を可能にする「データシェアリング機能」を提供。  
これにより、データエクスポートやコピー不要で共有が可能。

#### **(5) アプリケーション開発**

Snowflake はデータウェアハウスをアプリケーション基盤として利用することで、スケーラブルなデータ駆動型アプリケーションの開発をサポート。

---

### **2. ユースケースと導入事例**

- **Tableau**:
  Snowflake を採用してデータ分析を効率化。多くのデータをリアルタイムで分析する環境を構築。
- **InterWorks**:
  IoT デバイスからのセンサーデータを Snowpipe と Tasks を活用して処理。1 日 180 万件のデータをほぼゼロ管理で最適化。