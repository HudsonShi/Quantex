#!/usr/bin/env bash
# ============================================================================
#  单章编译检查脚本
#  用法：bash tools/check_chapter.sh ch05-financial-mathematics
#  作用：把某一章单独包成一个完整文档（复用 preamble.tex），编译两遍，
#        报告错误、缺字与未定义引用。用于章节改写后的自检。
# ============================================================================
set -uo pipefail

base="${1:-}"
if [ -z "$base" ]; then
  echo "用法: bash tools/check_chapter.sh <章节文件名（不含 .tex）>"
  echo "例:   bash tools/check_chapter.sh ch05-financial-mathematics"
  exit 2
fi
base="${base%.tex}"

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tex="$root/chapters/$base.tex"
if [ ! -f "$tex" ]; then
  echo "❌ 找不到章节文件：$tex"
  exit 2
fi

out="${TMPDIR:-/tmp}/quantex-check-$base"
rm -rf "$out"
mkdir -p "$out"

cat > "$out/$base.tex" <<EOF
\\documentclass[12pt,a4paper,openany,fontset=none]{ctexbook}
\\input{$root/preamble}
\\begin{document}
\\mainmatter
\\input{$tex}
\\end{document}
EOF

cd "$out" || exit 2
for i in 1 2; do
  if ! xelatex -interaction=nonstopmode -file-line-error "$base.tex" > "run$i.log" 2>&1; then
    echo "❌ 第 $i 遍编译失败"
    grep -nE "^[^ ]+\.tex:[0-9]+:|^!" "run$i.log" | head -40
    exit 1
  fi
done

if grep -q "^!" run2.log; then
  echo "❌ 存在 LaTeX 错误："
  grep -n "^!" -A6 run2.log | head -50
  exit 1
fi

pages=$(grep -o '([0-9]* pages' run2.log | tail -1 | tr -d '(' || true)
undef=$(grep -c "undefined" run2.log || true)
miss=$(grep -c "Missing character" run2.log || true)
over=$(grep -c "Overfull" run2.log || true)

echo "✅ $base 编译通过  →  $out/$base.pdf"
echo "   页数=${pages:-?}   未定义引用=${undef}   缺字=${miss}   Overfull=${over}"
if [ "${undef:-0}" != "0" ]; then
  echo "   —— 未定义引用明细："
  grep -n "undefined" run2.log | head -12
fi
if [ "${miss:-0}" != "0" ]; then
  echo "   —— 缺字明细："
  grep -n "Missing character" run2.log | head -6
fi
exit 0
