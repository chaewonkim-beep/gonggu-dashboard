#!/bin/bash
# Supabase gg_store 테이블 전체를 타임스탬프 붙여 로컬 JSON으로 백업.
# LLM Council 판결(2026-07-01): 탐지/복구 수단이 없다는 공백을 메우기 위한 최소 안전망.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_HTML="$DIR/index.html"
BACKUP_DIR="$DIR/backups"
mkdir -p "$BACKUP_DIR"

SB_URL=$(grep -o "const SB_URL = '[^']*'" "$INDEX_HTML" | sed "s/const SB_URL = '//;s/'$//")
SB_KEY=$(grep -o "const SB_KEY = '[^']*'" "$INDEX_HTML" | sed "s/const SB_KEY = '//;s/'$//")

TS=$(date "+%Y%m%d-%H%M%S")
OUT="$BACKUP_DIR/gg_store-$TS.json"

curl -s "$SB_URL/rest/v1/gg_store?select=*" \
  -H "apikey: $SB_KEY" \
  -H "Authorization: Bearer $SB_KEY" \
  -o "$OUT"

if [ -s "$OUT" ] && grep -q '"key"' "$OUT"; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') 백업 성공: $OUT"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') 백업 실패 또는 빈 응답: $OUT" >&2
  exit 1
fi

# 30일 지난 백업은 자동 정리 (디스크 무한증가 방지)
find "$BACKUP_DIR" -name "gg_store-*.json" -mtime +30 -delete
