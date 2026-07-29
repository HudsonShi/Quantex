#!/bin/bash
# Build standalone PDFs for each chapter

PREAMBLE=$(sed -n '1,/\\mainmatter/p' main.tex | sed '$d')

for ch in chapters/ch*.tex; do
    base=$(basename "$ch" .tex)
    num=$(echo "$base" | sed 's/ch\([0-9]*\)-.*/\1/')
    cat > "/tmp/${base}.tex" << EOF
$PREAMBLE
\\begin{document}
\\mainmatter
\\input{${ch}}
\\end{document}
EOF
    cd /Users/handashi/Desktop/Quantex
    xelatex -interaction=nonstopmode -output-directory=/tmp "/tmp/${base}.tex" > /dev/null 2>&1
    xelatex -interaction=nonstopmode -output-directory=/tmp "/tmp/${base}.tex" > /dev/null 2>&1
    mv "/tmp/${base}.pdf" "chapters/${base}.pdf"
    echo "Built: chapters/${base}.pdf"
done
echo "Done."
