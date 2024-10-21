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
