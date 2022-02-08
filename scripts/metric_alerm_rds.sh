#!/bin/sh

# RDS監視用のアラームを作成します。

topic_arn=
target_resource=
profile=

# CPU使用率80%以上
aws cloudwatch put-metric-alarm \
--alarm-name "${target_resource} RDS CPUUtilization >= 80%" \
--alarm-description "${target_resource} CPUUtilization Over 80%" \
--alarm-actions ${topic_arn} \
--namespace "AWS/RDS" \
--dimensions "{\"Name\": \"DBInstanceIdentifier\", \"Value\": \"${target_resource}\"}" \
--metric-name "CPUUtilization" \
--threshold 80 \
--comparison-operator "GreaterThanOrEqualToThreshold" \
--treat-missing-data "missing" \
--evaluation-periods 5 \
--datapoints-to-alarm 1 \
--period 60 \
--statistic "Average" \
--profile ${profile}

# 空きストレージ容量5GB未満
aws cloudwatch put-metric-alarm \
--alarm-name "${target_resource} RDS FreeStorageSpace < 5GB" \
--alarm-description "${target_resource} Free Storage Space Less Than 5GB" \
--alarm-actions ${topic_arn} \
--namespace "AWS/RDS" \
--dimensions "{\"Name\": \"DBInstanceIdentifier\", \"Value\": \"${target_resource}\"}" \
--metric-name "FreeStorageSpace" \
--threshold 5.0 \
--comparison-operator "LessThanThreshold" \
--treat-missing-data "missing" \
--evaluation-periods 5 \
--datapoints-to-alarm 1 \
--period 60 \
--statistic "Average" \
--profile ${profile}

# 空きメモリ未満
aws cloudwatch put-metric-alarm \
--alarm-name "${target_resource} RDS FreeableMemory < 400MB" \
--alarm-description "${target_resource} Freeable Memory Less Than 400MB" \
--alarm-actions ${topic_arn} \
--namespace "AWS/RDS" \
--dimensions "{\"Name\": \"DBInstanceIdentifier\", \"Value\": \"${target_resource}\"}" \
--metric-name "FreeableMemory" \
--threshold 0.4 \
--comparison-operator "LessThanThreshold" \
--treat-missing-data "missing" \
--evaluation-periods 5 \
--datapoints-to-alarm 1 \
--period 60 \
--statistic "Average" \
--profile ${profile}