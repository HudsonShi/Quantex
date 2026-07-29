# Quantex — 量化金融工程白皮书

<p align="center">
  <b>Quantitative Financial Engineering · LaTeX · 83 页</b>
</p>

## 关于本项目

Quantex 是一份用 LaTeX 撰写的量化金融工程课件/白皮书，覆盖从金融基础到高级量化模型的完整知识体系。全书共 **12 章、83 页**，适合量化研究员、金融工程师、FinTech 从业者及准备美国证券从业资格考试的学习者。

## 目录

| 章节 | 主题 | 内容概要 |
|:---:|------|---------|
| 1 | **金融入门** | 金融体系、核心工具、财务报表分析、利率理论、EMH |
| 2 | **金融科技** | AI/ML 金融应用、开放银行、量化信贷、RegTech、DeFi |
| 3 | **Web3** | 区块链共识、Solidity 安全、Tokenomics、AMM 数学、监管 |
| 4 | **金融工程** | BSM 定价、Greeks、波动率建模、结构化产品、CDS/CDO |
| 5 | **金融数学** | 利息/年金理论、债券数学、蒙特卡洛、有限差分法 |
| 6 | **Q Quant** | 测度变换、Girsanov、鞅定价、HJM/LMM、傅里叶方法 |
| 7 | **P Quant** | Fama-French/Barra 因子模型、Alpha 研究、回测方法论 |
| 8 | **概率统计分析** | 极值理论、MLE/GMM、贝叶斯推断、Black-Litterman |
| 9 | **时间序列** | ARIMA/GARCH、LSTM/GRU、Transformer (Informer/PatchTST) |
| 10 | **随机过程** | 布朗运动、伊藤引理、Levy 过程、Feynman-Kac |
| 11 | **组合优化** | Markowitz、收缩估计、风险平价、绩效归因 |
| 12 | **从业资格** | SIE、Series 7、57、65、24 考点全覆盖 |

## 编译

需要 XeLaTeX + ctex 宏包：

```bash
xelatex -interaction=nonstopmode main.tex
xelatex -interaction=nonstopmode main.tex  # 两遍确保目录/交叉引用正确
```

macOS 用户请注意：本项目配置了 `fontset=none` + 手动指定 macOS 系统字体（Songti SC / Heiti SC），避免 Windows 字体缺失问题。

## 项目结构

```
Quantex/
├── main.tex          # 主 LaTeX 文件
├── README.md
└── chapters/         # 12 个章节文件
    ├── ch01-intro-finance.tex
    ├── ch02-fintech.tex
    ├── ...
    └── ch12-certifications.tex
```

## License

MIT
