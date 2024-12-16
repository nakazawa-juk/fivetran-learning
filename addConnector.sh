# FivetranのAPIキーとシークレットを設定
API_KEY="xxxx"
API_SECRET_KEY="yyyy"

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
            "client_id": "xxxx.apps.googleusercontent.com",
            "client_secret": "xxxx"
        },
        "refresh_token": "xxxx",
        "access_token": "xxxx"
    }
}'

# APIリクエストの実行
curl -X POST "$URL" \
     -u "$API_KEY:$API_SECRET_KEY" \
     -H "Content-Type: application/json" \
     -d "$BODY" | jq
