#!/bin/sh

# Cloudwatchダッシュボードで監視する対象のリソース名。(必須)
export TARGET_RESOURCE_NAME=

# Cloudwatchダッシュボードで監視する対象のリソースタイプ。metrics.ymlのキーから選択してください。(必須)
export TARGET_RESOURCE_TYPE=

# 作成するCloudwatchダッシュボードの名前。(必須)
export DASHBOARD_NAME=

# Cloudwatchダッシュボードで監視する対象のリソースのリージョン。定義しない場合のデフォルト値はap-northeast-1です。
export TARGET_RESOURCE_REGION=

# 使用するプロファイル名。定義しない場合のデフォルト値はdefaultです。
export PROFILE=

python create_dashboard.py
