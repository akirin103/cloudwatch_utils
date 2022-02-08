#!/bin/sh

# Cloudwatchダッシュボードで監視する対象のリソース名。(必須)
export TARGET_RESOURCE_NAME=fuwa4dlink

# Cloudwatchダッシュボードで監視する対象のリソースタイプ。metrics.ymlのキーから選択してください。(必須)
export TARGET_RESOURCE_TYPE=rds

# 作成するCloudwatchダッシュボードの名前。(必須)
export DASHBOARD_NAME=fuwa4dlink_RDS

# Cloudwatchダッシュボードで監視する対象のリソースのリージョン。定義しない場合のデフォルト値はap-northeast-1です。
# export TARGET_RESOURCE_REGION=

# 使用するプロファイル名。定義しない場合のデフォルト値はdefaultです。
export PROFILE=4dlink_fw

python create_dashboard.py
