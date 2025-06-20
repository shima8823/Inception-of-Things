#!/bin/bash

# .envファイルを読み込む
if [ -f .env ]; then
  source .env
else
  echo ".envファイルが見つかりません"
  exit 1
fi

if [ -z "$GITLAB_TOKEN" ]; then
  echo "エラー: GITLAB_TOKENが設定されていません。"
  exit 1
fi

# localのgitlabにリポジトリをインポート
curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
     --header "Content-Type: application/json" \
     -X POST "http://localhost:8081/api/v4/projects" \
     --data '{"name":"IoT-shshimad","import_url":"https://github.com/shima8823/IoT-shshimad","visibility":"public"}'
