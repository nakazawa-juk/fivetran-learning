# RDS から S3 へデータ移行する方法

## **【方法１】S3 拡張機能を使う（RDS PostgreSQL 限定）**

Amazon RDS for PostgreSQL から S3 へのデータエクスポートは、`aws_s3`拡張機能を使用して行えます。

- 特徴:
  - S3 出力は csv と text と binary をサポート。Parquet は非サポート。

### 手順

1. 拡張機能のインストール  
   PostgreSQL に接続して、`aws_s3`拡張機能をインストールします。

   ```sql
   CREATE EXTENSION aws_s3 CASCADE;
   ```

2. S3 バケットの設定  
   S3 バケットを作成し、RDS インスタンスが S3 にアクセスできるように IAM ロールを設定します。

3. データのエクスポート  
   `aws_s3.query_export_to_s3`関数を使って、SQL クエリの結果を S3 にエクスポートします。
   ```sql
   SELECT aws_s3.query_export_to_s3(
      'COPY (SELECT * FROM your_table) TO STDOUT WITH CSV HEADER',
      aws_commons.create_s3_uri('your-bucket-name', 'your/filepath', 'ap-northeast-1')
   );
   ```

これで、指定した S3 バケットにデータが CSV 形式で保存されます。

## **【方法２】AWS Database Migration Service (DMS)**

- 特徴:
  - S3 出力は CSV と Parquet 形式をサポート。
  - 設定の柔軟性がある。増分データのみの転送も可能。
  - バッチまたはリアルタイムでのデータ移行が可能。
- 使用場面: 大規模データの移行や定期的な同期が必要な場合。

---

## **【方法３】AWS Glue**

ETL（抽出、変換、ロード）プロセスを自動化するためのサーバーレスサービスです。  
Fivetran の競合的サービスなので割愛。

---

## **【方法４】手動エクスポート + S3 アップロード**

SQL クエリやスクリプトを使い、データを CSV などにエクスポートし、それを S3 にアップロードする方法。

- 特徴:
  - シンプルかつコストが低い。
  - AWS CLI や SDK を使ったスクリプト化が可能。手動部分の自動化。
  - 大規模データにはあまり適さないと思う。
- 使用方法例:
  1. MySQL で`SELECT INTO OUTFILE`を使用してデータを CSV にエクスポート。
  ```
  SELECT *
  INTO OUTFILE '/path/to/output.csv'
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  FROM your_table;
  ```
  2. AWS CLI の`aws s3 cp`コマンドで S3 バケットにアップロード。

---

## **【方法５】RDS スナップショットを S3 にエクスポートする方法**

Amazon RDS はスナップショットからデータを抽出し、Amazon S3 バケットに保存する方法。  
データは Apache Parquet 形式で保存されます。

1. Amazon RDS からデータベーススナップショットを作成します。
2. エクスポート設定:
   • IAM ロール: S3 への書き込み権限を持つ IAM ロールを準備。
   • KMS キー: データの暗号化には AWS KMS キーを使用。
   • S3 バケット指定: エクスポート先の S3 バケットを指定。このバケットは RDS と同じリージョンにある必要がああります。
3. エクスポート実行: AWS Management Console、CLI、または API を使用してスナップショットを S3 にエクスポートします。

---

## 選択のポイント

- 頻繁な更新があるデータ: AWS DMS または AWS Glue。
- 単発のデータ転送: 手動エクスポート + CLI またはスナップショットのエクスポート。
- 低コストを重視: 手動エクスポート。
