# cloudwatch_utils

### 使用方法
### Cloudwatchダッシュボード作成する
1. 環境変数を設定してください。

    |  環境変数  |  説明  |
    | ---- | ---- |
    |  TARGET_RESOURCE_NAME  |  Cloudwatchダッシュボードで監視する対象のリソース名。  |
    |  TARGET_RESOURCE_TYPE  |  Cloudwatchダッシュボードで監視する対象のリソースタイプ。有効な値は「4.参考」を確認してください。metrics.ymlのキーと対応しています。  |
    |  TARGET_RESOURCE_REGION  | Cloudwatchダッシュボードで監視する対象のリソースのリージョン。省略した場合はap-northeast-1が自動的に設定されます。  |
    |  PROFILE  |  使用するプロファイル名。省略した場合はdefaultが自動的に設定されます。  |
    |  DASHBOARD_NAME  |  作成するCloudwatchダッシュボード名。  |

2. 下記のコマンドを実行してください。

    ```sh
    sh dashboard.sh
    ```

3. AWSコンソールからCloudwatchを開き、環境変数`DASHBOARD_NAME`で指定したダッシュボードが作成されていることを確認してください。また、グラフの時刻が日本時間でない場合があります。その場合は下記のリンクを参考にタイムゾーンの設定を行なってください。

    [CloudWatch ダッシュボードの時間範囲またはタイムゾーン形式を変更する](https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/change_dashboard_time_format.html)

4. 参考

    |  リソース名  |  説明  |
    | ---- | ---- |
    | lambda | AWS Lambdaの監視用 |
    | rds-mysql | AWS RDSのmysql監視用 |
    | rds-postgresql | AWS RDSのpostgresql監視用 |

<br />

## 開発参考リンク
- [新機能 – Amazon CloudWatch ダッシュボードでの API と CloudFormation のサポート](https://aws.amazon.com/jp/blogs/news/new-api-cloudformation-support-for-amazon-cloudwatch-dashboards/)

<br />

## 開発者のために
Pythonの開発環境には`pipenv`(参考: [Pipenv: 人間のためのPython開発ワークフロー](https://pipenv-ja.readthedocs.io/ja/translate-ja/))を使用しています。  
プロジェクトルートに`.vscode/settings.json`を作成して下記の値を入力してください。
```
{
  "python.pythonPath": "<pipenv shellした後にwhich pythonした値>",
  "python.autoComplete.extraPaths": [
    "<pipenv shellした後にwhich pythonした値>"
  ],
  "python.analysis.extraPaths": ["<pipenv shellした後にwhich pythonした値>"],
  "python.linting.pylintEnabled": false,
  "python.linting.flake8Enabled": true,
  "python.linting.enabled": true,
  "python.linting.flake8Args": [
    "--max-line-length",
    "88",
    "--ignore=E203,W503,W504"
  ],
  "python.formatting.provider": "black",
  "editor.formatOnSave": true
}
```
