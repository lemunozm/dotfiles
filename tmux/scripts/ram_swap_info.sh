#!/usr/bin/env bash

if [[ "$(uname)" == "Darwin" ]]; then
  total_bytes=$(sysctl -n hw.memsize)

  stats=$(vm_stat)
  page_size=$(echo "$stats" | head -1 | grep -oE '[0-9]+')
  sum_pages() {
    grep -Eo '[0-9]+' | awk '{ s += $1 } END { print s+0 }'
  }

  used_and_cached=$(echo "$stats" | grep -E "(Pages active|Pages inactive|Pages speculative|Pages wired down|Pages occupied by compressor)" | sum_pages)
  cached=$(echo "$stats" | grep -E "(Pages purgeable|File-backed pages)" | sum_pages)
  used_bytes=$(( (used_and_cached - cached) * page_size ))

  used_gb=$(awk "BEGIN { printf \"%.1f\", $used_bytes / 1073741824 }")
  total_gb=$(awk "BEGIN { printf \"%.1f\", $total_bytes / 1073741824 }")

  swap_used_mb=$(sysctl vm.swapusage 2>/dev/null | grep -oE 'used = [0-9.]+' | grep -oE '[0-9.]+')
  swap_gb=$(awk "BEGIN { printf \"%.1f\", ${swap_used_mb:-0} / 1024 }")

  echo "${used_gb}GB|${swap_gb}GB"

elif command -v free &>/dev/null; then
  free -b | awk '
    $1 == "Mem:" { printf "%.1f/%.1f GB | Swap ", $3/1073741824, $2/1073741824 }
    $1 == "Swap:" { printf "%.1f GB\n", $3/1073741824 }
  '
fi
