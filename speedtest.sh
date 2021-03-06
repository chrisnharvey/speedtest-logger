#!/bin/bash

SPEEDTEST_OUTPUT=$(speedtest --f json)
DOWN_SPEED_BYTES=$(echo $SPEEDTEST_OUTPUT | jq .download.bandwidth)
UP_SPEED_BYTES=$(echo $SPEEDTEST_OUTPUT | jq .upload.bandwidth)
PING=$(echo $SPEEDTEST_OUTPUT | jq .ping.latency)
JITTER=$(echo $SPEEDTEST_OUTPUT | jq .ping.jitter)
PACKET_LOSS=$(echo $SPEEDTEST_OUTPUT | jq .packetLoss)
RESULT_URL=$(echo $SPEEDTEST_OUTPUT | jq .result.url)
SERVER_ID=$(echo $SPEEDTEST_OUTPUT | jq .server.id)
SERVER_NAME=$(echo $SPEEDTEST_OUTPUT | jq .server.name)

DOWN_SPEED_MBPS=$(echo "scale=2; $DOWN_SPEED_BYTES/125000" | bc)
UP_SPEED_MBPS=$(echo "scale=2; $UP_SPEED_BYTES/125000" | bc)

DATE=$(date --utc +%FT%TZ)

echo "$DATE Down: $DOWN_SPEED_MBPS - Up: $UP_SPEED_MBPS - Ping: $PING - Jitter: $JITTER - Packet Loss: $PACKET_LOSS - Server: $SERVER_NAME ($SERVER_ID) - Result: $RESULT_URL"
