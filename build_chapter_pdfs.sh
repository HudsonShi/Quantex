#!/usr/bin/env bash
# ============================================================================
#  为每一章生成独立 PDF（输出到 chapters/<name>.pdf，供 README 链接使用）
#
#  用法：
#      bash build_chapter_pdfs.sh            # 编译全部 12 章
#      bash build_chapter_pdfs.sh ch05 ch06  # 只编译指定章节（可省略前缀）
#
#  说明：本脚本复用 tools/check_chapter.sh，因此每一章都会真正被编译两遍，
#        并且在出错时明确报告，而不是静默失败。
# ============================================================================
set -uo pipefail
cd "$(dirname "$0")" || exit 1

targets=()
if [ "$#" -gt 0 ]; then
  for arg in "$@"; do
    arg="${arg%.tex}"
    if [ -f "chapters/$arg.tex" ]; then
      targets+=("chapters/$arg.tex")
    else
      # 允许只写章号，例如 ch05 / 05 / 5
      num="$(printf '%s' "$arg" | tr -dc '0-9')"
      if [ -n "$num" ]; then
        num="$(printf '%02d' "$((10#$num))")"
        match=(chapters/ch"$num"-*.tex)
        if [ -f "${match[0]}" ]; then
          targets+=("${match[0]}")
          continue
        fi
      fi
      echo "⚠ 跳过无法识别的参数：$arg"
    fi
  done
else
  for ch in chapters/ch*.tex; do targets+=("$ch"); done
fi

if [ "${#targets[@]}" -eq 0 ]; then
  echo "没有需要编译的章节。"
  exit 1
fi

fail=0
built=0
for ch in "${targets[@]}"; do
  base="$(basename "$ch" .tex)"
  echo "───────────────────────────────────────────────"
  echo "▶ 编译 $base"
  if bash tools/check_chapter.sh "$base"; then
    out="${TMPDIR:-/tmp}/quantex-check-$base"
    cp "$out/$base.pdf" "chapters/$base.pdf"
    echo "  ↳ 已输出 chapters/$base.pdf"
    built=$((built + 1))
  else
    echo "  ✗ $base 编译失败，保留旧 PDF（如有）"
    fail=$((fail + 1))
  fi
done

echo "───────────────────────────────────────────────"
echo "完成：成功 $built 章，失败 $fail 章。"
[ "$fail" -eq 0 ] || exit 1
