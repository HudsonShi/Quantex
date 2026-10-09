# Quantex 内部讲义

<p align="center">
  <b>量化金融工程 · Quantitative Financial Engineering</b><br>
  内部讲义 · 从金融基础到 Q/P Quant 的系统化知识地图<br>
  LaTeX（XeLaTeX + ctex）· 12 章 · 5 篇 · 236 页 · 含公式速查 / Python 工具链 / 术语对照附录
</p>

<p align="center">
  <a href="./main.pdf"><b>📖 下载完整 PDF</b></a>
</p>

---

## 关于本项目

本讲义用 LaTeX 撰写，覆盖从金融市场基础、金融科技与 Web3，
到衍生品定价、随机分析、因子投资与组合优化的完整知识体系。

写作原则是 **「公式—直觉—应用—风险」四件套**：每个重要公式都尽量给出直观解释、实际用途与失效条件。
全书用统一的符号体系与统一的叙事逻辑组织——**Q Quant 给出无套利约束下的相对价格，P Quant 给出真实测度下的统计规律，
二者共享同一套概率与数值工具**。

## 内容结构

| 篇 | 章 | 主题 | 内容概要 |
|:--:|:--:|------|---------|
| 一 | 1 | [**金融入门**](./chapters/ch01-intro-finance.pdf) | 金融体系、货币市场工具、股债估值、久期与凸性、收益率曲线三大理论、EMH 与行为金融 |
| 一 | 2 | [**金融科技**](./chapters/ch02-fintech.pdf) | 数据基础设施、信用评分卡（WOE/IV/PDO）、预期损失与 RAROC、模型风险治理、开放银行、支付清算 |
| 一 | 3 | [**Web3 与加密金融**](./chapters/ch03-web3.pdf) | 区块链与共识、EVM/Gas、Solidity 安全、AMM 数学、无常损失、代币经济学、MEV、监管 |
| 二 | 4 | [**金融工程**](./chapters/ch04-financial-engineering.pdf) | 远期与期货定价、BSM 与 Greeks 解析式、波动率微笑、Heston/SABR、结构化产品、CDS 与 XVA |
| 二 | 5 | [**金融数学**](./chapters/ch05-financial-mathematics.pdf) | 利息与年金理论、债券数学、收益率曲线拟合、BS PDE 推导、二叉树、有限差分、蒙特卡洛与方差缩减 |
| 三 | 6 | [**Q Quant**](./chapters/ch06-q-quant.pdf) | 等价鞅测度与 Girsanov、计价单位变换、Vasicek/CIR/HJM/LMM、信用与波动率衍生品、傅里叶定价、LSM |
| 四 | 7 | [**P Quant**](./chapters/ch07-p-quant.pdf) | 因子模型与 Barra、Alpha 研究（IC/IR）、机器学习选股、回测方法论与多重检验、市场微观结构 |
| 四 | 8 | [**金融概率与统计**](./chapters/ch08-probability-statistics.pdf) | 分布族与肥尾、MLE/GMM、贝叶斯与 Black-Litterman、MCMC、极值理论、面板回归与因果推断 |
| 四 | 9 | [**时间序列**](./chapters/ch09-time-series.pdf) | ARIMA/SARIMA、GARCH 族、已实现波动率与 HAR、状态空间与卡尔曼滤波、协整、LSTM/Transformer |
| 三 | 10 | [**随机过程**](./chapters/ch10-stochastic-processes.pdf) | 鞅与停时、布朗运动、伊藤积分与引理、OU 过程、跳跃与 Lévy 过程、Girsanov、Feynman-Kac、HJB |
| 五 | 11 | [**组合优化**](./chapters/ch11-portfolio-optimization.pdf) | Markowitz 与有效前沿、收缩估计、鲁棒优化、风险平价/ERC、HRP、Kelly、CVaR 优化、绩效归因 |
| 五 | 12 | [**美国证券从业资格**](./chapters/ch12-certifications.pdf) | SIE、Series 7/57/65/24 考点全覆盖，含债券定价、保证金、税收等价收益率等计算例题 |

## 规模统计（第二版）

| 指标 | 第一版 | 第二版 |
|---|---|---|
| 全书页数 | 83 | **236** |
| 章节源码行数 | 2,583 | **9,024** |
| 公式环境 | 158 | **285** |
| 插图（TikZ / pgfplots） | 0 | **35** |
| 表格 | 8 | **52** |
| 可运行代码示例 | 0 | **17** |
| 算法伪代码 | 0 | **4** |
| 交叉引用 `\cref` | 0 | **296** |
| 定义 / 例 / 定理 | 8 / 1 / 2 | **13 / 49 / 17** |
| 彩色提示盒（要点/警示/应用/直觉/说明） | 4 | **25 / 41 / 20 / 19 / 18** |
| 参考文献条目 | 0 | **110** |

**附录**

| 附录 | 内容 |
|:--:|------|
| A | [数学公式速查](./main.pdf) —— 常用分布、高斯积分、矩阵代数、随机分析公式、希腊字母表、数值方法速查 |
| B | [Python 量化工具链](./main.pdf) —— 环境配置、数据清洗、波动率建模、因子研究、组合优化、衍生品定价的可运行代码 |
| C | [术语中英对照](./main.pdf) —— 约 120 条术语，按市场产品 / 定价 / 统计 / 组合风险 / Web3 与监管分组 |
| — | [参考文献](./main.pdf) —— 按 8 个主题整理的经典文献（Markowitz、Black–Scholes、Heston、Fama–French、Kyle、Longstaff–Schwartz 等） |

## 特色

- **图文并茂**：TikZ/pgfplots 绘制的收益曲线、波动率微笑、有效前沿、二叉树、CPMM 曲线、布朗路径等示意图；
- **可运行代码**：每章配有可直接执行的 Python（以及 Solidity）代码片段，注释与变量名均为英文以保证跨平台可运行；
- **七类彩色盒子**：核心要点、定义/例、风险警示、实务应用、直觉理解、补充说明、考试要点，语义严格区分；
- **规范的交叉引用**：`cleveref` 中文引用（「见式 (4.3)」「见定义 11.2」），公式/图/表/算法按章编号；
- **每章三件套**：本章小结 + 练习与思考 + 延伸阅读；
- **完整前置与后置部分**：封面、前言、阅读指南与全书地图、符号表、附录、参考文献。

## 编译

需要 TeX Live（含 `ctex`、`tcolorbox`、`fontawesome5`、`pgfplots`、`cleveref`、`arch` 等宏包）与 XeLaTeX：

```bash
# 全书（建议跑两遍以正确生成目录与交叉引用）
xelatex -interaction=nonstopmode main.tex
xelatex -interaction=nonstopmode main.tex

# 单章检查（编译两遍 + 报告错误 / 缺字 / 未定义引用 / Overfull）
bash tools/check_chapter.sh ch05-financial-mathematics

# 生成 12 个单章 PDF（供 README 链接）
bash build_chapter_pdfs.sh

# 只编译指定章节
bash build_chapter_pdfs.sh ch05 ch06
```

macOS 用户请注意：本项目配置了 `fontset=none` 并手动指定 macOS 系统字体
（Songti SC 正文 / Heiti SC 标题 / Kaiti SC 强调），避免 Windows 字体缺失问题。
在 Linux 上编译时，只需修改 `preamble.tex` 中 `\setCJKmainfont` 等三行。

## 项目结构

```
Quantex/
├── main.tex                     # 主文件（前置部分 + 12 章 + 附录 + 参考文献）
├── preamble.tex                 # 统一导言区：样式、彩色盒子、算法/代码、数学宏
├── main.pdf                     # 完整 PDF
├── build_chapter_pdfs.sh        # 生成 12 个单章 PDF
├── tools/
│   └── check_chapter.sh         # 单章编译检查（错误 / 缺字 / 未定义引用 / Overfull）
├── frontmatter/
│   ├── cover.tex                # 封面（TikZ）
│   ├── preface.tex              # 前言（含第二版修订说明）
│   ├── guide.tex                # 阅读指南与全书地图
│   └── notation.tex             # 符号表
├── chapters/                    # 12 章（.tex + 单章 .pdf）
│   ├── ch01-intro-finance.tex
│   ├── …
│   └── ch12-certifications.tex
├── appendix/
│   ├── a-math-formulas.tex      # 附录 A 数学公式速查
│   ├── b-python-toolchain.tex   # 附录 B Python 量化工具链
│   └── c-glossary.tex           # 附录 C 术语中英对照
├── backmatter/
│   └── bibliography.tex         # 参考文献
├── docs/
│   ├── 项目审阅报告.md            # 本次审阅发现的问题与修订记录
│   └── 写作规范.md                # 章节写作契约（环境语法、符号、自检流程）
└── README.md
```

## 许可

MIT
