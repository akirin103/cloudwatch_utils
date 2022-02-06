import boto3
import json
import logging
import math
import os
import yaml
import my_logger


logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


def main():
    logger.info("処理を開始します。")
    # 環境変数取得
    target_resource_name = os.environ.get("TARGET_RESOURCE_NAME", "")
    target_resource_type = os.environ.get("TARGET_RESOURCE_TYPE", "")
    if target_resource_name == "":
        logger.error("対象リソース名を指定してくだささい。")
        return
    if target_resource_type == "":
        logger.error("対象リソースタイプを指定してくだささい。")
        return
    target_resource_region = os.environ.get("TARGET_RESOURCE_REGION", "ap-northeast-1")
    profile = os.environ.get("PROFILE", "default")
    dashboard_name = os.environ.get("DASHBOARD_NAME", target_resource_name)

    logger.info("対象リソース名: {}".format(target_resource_name))
    logger.info("対象リソースタイプ: {}".format(target_resource_type))
    logger.info("対象リソースリージョン: {}".format(target_resource_region))
    logger.info("使用プロファイル: {}".format(profile))
    # 監視項目取得
    metrics_items = get_metrics_item(target_resource_type)
    if len(metrics_items) == 0:
        logger.error("対象リソースの設定が見つかりませんでした。")
        return

    # Cloudwatchダッシュボード作成
    create_dashboard(
        target_resource_name,
        target_resource_region,
        profile,
        dashboard_name,
        metrics_items,
    )


def get_metrics_item(target):
    with open("./metrics.yml") as file:
        metrics_items = yaml.safe_load(file)
        target_lower = target.lower()
        return metrics_items.get(target_lower, [])


def create_dashboard(
    resource_name, resource_region, profile, dashboard_name, metrics_items
):
    logger.info(profile)
    widgets = []
    for i, item in enumerate(metrics_items["item"]):
        obj = {
            "height": 6,
            "width": 6,
            "type": "metric",
        }
        obj["x"] = (i + 4) % 4 * 6
        obj["y"] = math.floor(i / 4) * 6
        obj["properties"] = {
            "view": "timeSeries",
            "stacked": False,
            "metrics": [
                [
                    metrics_items["kind"],
                    item,
                    metrics_items["identifer"],
                    resource_name,
                ]
            ],
            "region": resource_region,
        }
        widgets.append(obj)
    body = {"widgets": widgets}
    body_j = json.dumps(body)
    my_session = boto3.Session(profile_name=profile)
    cw = my_session.client("cloudwatch")
    cw.put_dashboard(DashboardName=dashboard_name, DashboardBody=body_j)


if __name__ == "__main__":
    logger = my_logger.root_logger()
    main()
