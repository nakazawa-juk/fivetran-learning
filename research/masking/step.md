# 調査方法のステップ

1. **公式ドキュメントとブログ記事の確認**

   - Fivetran の公式ドキュメントやブログ記事を確認し、マスキング機能の概要とその実装方法について理解します。特に、以下の記事が参考になります：
     - [Protecting Sensitive Data Across Every Fivetran Connector](https://www.fivetran.com/blog/protecting-sensitive-data-across-every-connector?t)
     - [Best of 2021: Fivetran's Year in Review](https://www.fivetran.com/blog/best-of-2021-fivetrans-year-in-review?t)

   **確認ポイント**:

   - マスキング機能がどのコネクターで利用可能か（すべてのコネクターで利用可能かどうか）。
   - カラムブロック（Column Blocking）とカラムハッシュ化（Column Hashing）の違い。
   - マスキング機能がどのような規制対応（GDPR, HIPAA, PCI DSS など）に役立つか。

2. **ユースケースの特定**

   - マスキング機能がどのようなユースケースで有効かを調査します。例えば、以下のようなシナリオで利用されます：
     - **金融データ**: クレジットカード情報や銀行口座情報など、PCI DSS 対応が必要なデータ。
     - **医療データ**: 患者情報（PHI）など、HIPAA 対応が必要なデータ。
     - **人事・給与情報**: 社員の個人情報や給与データなど。

3. **セキュリティとコンプライアンスへの影響**

   - マスキング機能がセキュリティ面およびコンプライアンス面でどのような効果を発揮するかを分析します。特に以下の点について調査します：
     - **GDPR 対応**: 個人情報保護規制に準拠するため、不要な個人情報がデータウェアハウスに保存されないようにする。
     - **PCI DSS 対応**: クレジットカード情報などセンシティブな支払い情報が適切に保護されること。
