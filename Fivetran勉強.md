# Fivetran の勉強メモ

案件で Fivetran を使う予定なのでキャッチアップしておきたい。<br>
作業中、記録したいと思ったことをここにメモする。

## 知見

### ■ 知見 ① AWS RDS の作り方

1. AWS RDS に DB インスタンス を作る。

- エンジンタイプ
  - PostgreSQL
- DB インスタンス識別子
  - for-fivetran-learning
- マスターユーザー名
  - postgres
- 認証情報管理
  - セルフマネージド
- マスターパスワード
  - f9d02ndirsf

2. 作成した DB インスタンスに DB を作る。

```
// インスタンスに接続
> psql -h <インスタンスのエンドポイント> -U <ユーザー名> -d postgres -p 5432
password:

// データベース一覧の表示
> \l

// DBを作成
>create database <データベース名>;
```

3. Fivetran から接続する。

### ■ 知見 ② Fivetran API の設定

1. ダッシュボード左下の「API Key」を選択
2. 「Generate new secrete」を選択  
   API Key: B27zjJv9FKoWnegi
   API Secret: jnsoascLcUzDBUDkUW60uGg8pD1edvoc
   Base64-encoded API key: QjI3empKdjlGS29XbmVnaTpqbnNvYXNjTGNVekRCVURrVVc2MHVHZzhwRDFlZHZvYw==
3. API Key を API リクエストに含めて使う。

### ■ 知見 ② Fivetran API でユーザー情報を取得する

distination に設定した postgres に挿入されたユーザー情報を、Fivetran API を使って取得してみる。

1. curl で API を叩く

```
curl -X GET "https://api.fivetran.com/v1/users" -u B27zjJv9FKoWnegi:jnsoascLcUzDBUDkUW60uGg8pD1edvoc | jq
```

レスポンス ↓

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   341  100   341    0     0    518      0 --:--:-- --:--:-- --:--:--   519
{
  "code": "Success",
  "data": {
    "items": [
      {
        "id": "forty_unanimous",
        "email": "nakajuki6045@gmail.com",
        "given_name": "Jukiya",
        "family_name": "Nakazawa",
        "verified": true,
        "invited": false,
        "picture": null,
        "phone": "07085100706",
        "role": "Account Administrator",
        "logged_in_at": "2024-10-17T04:39:00.389Z",
        "created_at": "2024-10-17T04:38:27.369689Z",
        "active": true
      }
    ]
  }
}
```

### ■ 知見 ③ Fivetran API でコネクターを追加する

試しに Google Calendar のコネクタを作る。

1. 必要な情報を用意する。

- group_id: Fivetran で適当なコネクターを選択すると URL から group_id を確認できる。
- Auth の設定: 知見 ④ を行う。

2. addConnector.sh を作る。

```
# FivetranのAPIキーとシークレットを設定
API_KEY="B27zjJv9FKoWnegi"
API_SECRET_KEY="jnsoascLcUzDBUDkUW60uGg8pD1edvoc"

# APIエンドポイント
URL="https://api.fivetran.com/v1/connectors"

# リクエストボディ
BODY='{
    "service": "google_calendar",
    "group_id": "grade_spontaneous",
    "config": {
    	"schema": "google_calendar"
  	},
    "auth": {
        "client_access": {
            "client_id": "4152769596-den4paj21oq7r72ccs9gioh7eb1pinq9.apps.googleusercontent.com",
            "client_secret": "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"
        },
        "refresh_token": "1//0eebM6P09H_UhCgYIARAAGA4SNwF-L9IrHws_9f3mipaIU2c43uHjaLzA7neee5M4Cs9Pug6kkUbX1Q4YyiOiW_jNX9KKdHZz-3c",
        "access_token": "ya29.a0AcM612x58UFuDqxk26_7u-lOunAhn4ss5cj9J3xU7qIqNaQPCu7xqaIPlUfYngO1_yk8I5e-2TBLuKYxUFiMuchYKCMbH7wtHSJcP_0zqIEWyhh9tvgSON_e-ijsMF25iX1JILNXIiNhz8T0A3pFeqpBmrfAd-uQhIR4EU9BaCgYKAQYSARASFQHGX2MiJur7x5cBCaPMuVCrUwuMqA0175"
    }
}'

# APIリクエストの実行
curl -X POST "$URL" \
     -u "$API_KEY:$API_SECRET_KEY" \
     -H "Content-Type: application/json" \
     -d "$BODY" | jq

```

3. ターミナルで、sh ファイルを置いたディレクトリに移動して、chmod コマンドを使って実行権限を付与する。

```
chmod +x addConnector.sh
```

4. API を叩く

```
./addConnector.sh
```

レスポンス ↓

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1516  100   782  100   734     33     31  0:00:23  0:00:23 --:--:--   167
{
  "code": "Success",
  "message": "Connector has been created",
  "data": {
    "id": "armored_nibble",
    "group_id": "grade_spontaneous",
    "service": "google_calendar",
    "service_version": 0,
    "schema": "google_calendar",
    "connected_by": "forty_unanimous",
    "created_at": "2024-10-17T08:03:42.343229Z",
    "succeeded_at": null,
    "failed_at": null,
    "paused": false,
    "pause_after_trial": false,
    "sync_frequency": 360,
    "data_delay_threshold": 0,
    "data_delay_sensitivity": "NORMAL",
    "private_link_id": null,
    "networking_method": "Directly",
    "proxy_agent_id": null,
    "schedule_type": "auto",
    "status": {
      "setup_state": "connected",
      "schema_status": "ready",
      "sync_state": "scheduled",
      "update_state": "on_schedule",
      "is_historical_sync": true,
      "tasks": [],
      "warnings": []
    },
    "setup_tests": [
      {
        "title": "Connecting to API",
        "status": "PASSED",
        "message": ""
      }
    ],
    "config": {}
  }
}
```

5. Distination に設定された Warehouse に、Google Calendar の内容が挿入されていることを確認する。

### ■ 知見 ④ Google OAuth 情報の取得手順（Google Calendar）

Google OAuth 情報（`client_id`, `client_secret`, `refresh_token`, `access_token`）を取得する手順は以下の通りです。

#### ステップ 1: Google Cloud Platform（GCP）のプロジェクトを作成

1. **Google Cloud Console にアクセス**  
   Google Cloud Console にアクセスし、Google アカウントでログインします。
2. **新しいプロジェクトを作成**
   - 画面の上部にある「プロジェクトの選択」ボタンをクリックします。
   - 「新しいプロジェクト」をクリックし、プロジェクト名を入力して作成します。

#### ステップ 2: Google Calendar API を有効化

1. **API とサービスに移動**  
   左側のメニューから「API とサービス」 > 「ライブラリ」を選択します。
2. **Google Calendar API を検索**  
   検索ボックスに「Google Calendar API」と入力し、表示された API を選択します。
3. **API を有効化**  
   「有効にする」ボタンをクリックして API を有効にします。

#### ステップ 3: OAuth 2.0 クライアント ID を作成

1. **OAuth 同意画面の設定**

   - 左側のメニューから「API とサービス」 > 「OAuth 同意画面」を選択します。
   - 「外部」を選択し、「作成」をクリックします。
   - 必要な情報（アプリ名、ユーザーサポートメールなど）を入力し、保存します。

2. **クライアント ID の作成**

   - 左側のメニューから「認証情報」を選択します。
   - 「認証情報を作成」ボタンをクリックし、「OAuth クライアント ID」を選択します。
   - アプリケーションの種類を「ウェブアプリケーション」に選択します。

3. **リダイレクト URI の設定**

   - リダイレクト URI を指定する必要があります。これは、OAuth 認証が完了した後にユーザーがリダイレクトされる URI です。
   - `http://localhost` や、Fivetran が指定する URI を設定します（具体的な URI は Fivetran のドキュメントで確認してください）。
   - 「作成」ボタンをクリックします。

4. **クライアント ID とクライアントシークレットの取得**
   - 作成が完了すると、クライアント ID とクライアントシークレットが表示されます。この情報をメモしておきます。

#### ステップ 4: アクセストークンとリフレッシュトークンの取得

1. **OAuth 2.0 認証フローを実行**

   - ブラウザを開いて次の URL にアクセスします（`<client_id>`は手順 3 で取得したクライアント ID に置き換えてください）。

   ```bash
   https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=<client_id>&redirect_uri=http://localhost&scope=https://www.googleapis.com/auth/calendar&access_type=offline
   ```

   - 認証画面が表示されたら、Google アカウントでログインし、権限を許可します。

2. **認証コードの取得**

   - 認証後、指定したリダイレクト URI（この場合は`http://localhost`）にリダイレクトされます。URL のパラメータに`code`が付与されていることを確認します。この`code`をメモします。

3. **アクセストークンとリフレッシュトークンの取得**
   - 次のコマンドを使用してアクセストークンとリフレッシュトークンを取得します。`<client_id>`、`<client_secret>`、`<redirect_uri>`、`<authorization_code>`をそれぞれ実際の値に置き換えます。
   ```bash
   curl --request POST \
        --data "code=<authorization_code>" \
        --data "client_id=<client_id>" \
        --data "client_secret=<client_secret>" \
        --data "redirect_uri=http://localhost" \
        --data "grant_type=authorization_code" \
        https://oauth2.googleapis.com/token
   ```
   - これにより、JSON 形式で`access_token`と`refresh_token`が含まれたレスポンスが返されます。これらのトークンをメモしておきます。

#### ステップ 5: 取得した情報を Fivetran に設定

- 取得した `client_id`, `client_secret`, `refresh_token`, `access_token` を Fivetran のリクエストボディに入力します。

これで Google OAuth 情報を準備する手順は完了です！Fivetran でのデータ同期に必要な認証情報が揃いました。
