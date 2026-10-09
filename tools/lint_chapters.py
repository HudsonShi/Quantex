#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""
章节一致性检查（lint）
用法：python3 tools/lint_chapters.py [chapters/ch05-financial-mathematics.tex ...]
不带参数时检查 chapters/ 下全部章节。

检查项：
  1. 禁用命令：\\cite / \\bibliography / \\includegraphics
  2. 表格浮动参数不得使用单个 [h]
  3. section/subsection 标题中不得出现数学模式 $
  4. 代码清单内不得出现中文字符
  5. 章末三件套是否存在：summarybox / exercises / furtherreading
  6. 环境配对（begin/end 数量）
  7. 图片、表格、公式、代码、\cref 的数量统计
  8. 章节总行数、是否有 \label 缺失的 figure/table
"""
import re
import sys
import glob
import os

CJK = re.compile(r'[\u3400-\u9fff\u3000-\u303f\uff00-\uffef]')

def environments(text):
    return re.findall(r'\\begin\{([A-Za-z*@]+)\}', text), re.findall(r'\\end\{([A-Za-z*@]+)\}', text)

def check(path):
    with open(path, encoding='utf-8') as f:
        text = f.read()
    lines = text.split('\n')
    name = os.path.basename(path)
    problems = []

    # 1. 禁用命令
    for cmd in (r'\cite', r'\bibliography', r'\includegraphics', r'\include{'):
        for i, line in enumerate(lines, 1):
            if cmd in line and not line.lstrip().startswith('%'):
                problems.append(f"L{i}: 使用了禁用命令 {cmd}")

    # 2. 浮动参数
    for i, line in enumerate(lines, 1):
        m = re.search(r'\\begin\{(table|figure)\}\[([^\]]*)\]', line)
        if m and m.group(2).strip() == 'h':
            problems.append(f"L{i}: {m.group(1)} 浮动参数为 [h]，请改为 [htbp]")

    # 3. 标题中的数学模式
    for i, line in enumerate(lines, 1):
        if re.match(r'\s*\\(sub)*section\*?\{', line) and '$' in line:
            problems.append(f"L{i}: 标题中含有数学模式 $...$（会影响 PDF 书签）")

    # 4. 代码清单中的中文
    in_code = False
    in_opts = False
    code_start = 0
    for i, line in enumerate(lines, 1):
        if r'\begin{lstlisting}' in line:
            code_start = i
            if '[' in line and ']' not in line.split('[', 1)[1]:
                in_opts = True          # 选项参数跨行，其后的 caption 允许中文
            inn = line.split('[', 1)[1] if '[' in line else ''
            in_code = not in_opts
        elif in_opts:
            if ']' in line:
                in_opts = False
                in_code = True
        elif r'\end{lstlisting}' in line:
            in_code = False
        elif in_code and CJK.search(line):
            problems.append(f"L{i}: 代码清单（起于 L{code_start}）中出现中文字符")

    # 5. 章末三件套
    for env in ('summarybox', 'exercises', 'furtherreading'):
        if f'\\begin{{{env}}}' not in text:
            problems.append(f"缺少章末环境：{env}")

    # 6. 环境配对
    begins, ends = environments(text)
    from collections import Counter
    cb, ce = Counter(begins), Counter(ends)
    for env in set(cb) | set(ce):
        if cb[env] != ce[env]:
            problems.append(f"环境不配对：{env} begin={cb[env]} end={ce[env]}")

    # 7. 统计
    stats = {
        '行数': len(lines),
        '章节级 \\section': len(re.findall(r'^\\section\{', text, re.M)),
        '公式环境': len(re.findall(r'\\begin\{(equation|align|gather)\*?\}', text)),
        '图 figure': len(re.findall(r'\\begin\{figure\}', text)),
        '表 table': len(re.findall(r'\\begin\{table\}', text)),
        '代码 lstlisting': len(re.findall(r'\\begin\{lstlisting\}', text)),
        '算法 algorithm': len(re.findall(r'\\begin\{algorithm\}', text)),
        '交叉引用 \\cref': len(re.findall(r'\\[cC]ref\{', text)),
        '标签 \\label': len(re.findall(r'\\label\{', text)),
        '定义': len(re.findall(r'\\begin\{definition\}', text)),
        '例': len(re.findall(r'\\begin\{example\}', text)),
        '定理类': len(re.findall(r'\\begin\{(theorem|proposition|lemma|corollary)\}', text)),
        'keybox': len(re.findall(r'\\begin\{keybox\}', text)),
        'warningbox': len(re.findall(r'\\begin\{warningbox\}', text)),
        'appbox': len(re.findall(r'\\begin\{appbox\}', text)),
        'intuitionbox': len(re.findall(r'\\begin\{intuitionbox\}', text)),
        'notebox': len(re.findall(r'\\begin\{notebox\}', text)),
    }

    # 8. figure/table 缺 label
    for m in re.finditer(r'\\begin\{(figure|table)\}(.*?)\\end\{\1\}', text, re.S):
        if r'\label{' not in m.group(2):
            line = text[:m.start()].count('\n') + 1
            problems.append(f"L{line}: {m.group(1)} 环境缺少 \\label")

    return name, stats, problems


def main():
    args = sys.argv[1:]
    files = args if args else sorted(glob.glob('chapters/ch*.tex'))
    if not files:
        print('未找到章节文件'); return 1
    total_problems = 0
    for path in files:
        name, stats, problems = check(path)
        status = '✅' if not problems else '⚠'
        print(f"\n{status} {name}")
        print('   ' + '  '.join(f'{k}={v}' for k, v in stats.items()))
        for p in problems:
            print(f'   - {p}')
        total_problems += len(problems)
    print(f"\n=== 共 {total_problems} 个问题 ===")
    return 0 if total_problems == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
