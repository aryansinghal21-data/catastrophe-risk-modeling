# 🌪️ Catastrophe Risk Modeling & Loss Estimation
*Reinsurance | Python | SQL | Monte Carlo Simulation | Actuarial Science*

---

## 📋 Business Problem
Reinsurance companies must quantify catastrophe exposure before pricing treaties. This project builds a complete CAT risk model using actuarial frequency-severity methodology and Monte Carlo simulation.

---

## 🎯 Key Results

| Metric | Value |
|--------|-------|
| Monte Carlo Simulations | 10,000 iterations |
| Frequency Model | Poisson distribution (KS-test validated) |
| Severity Model | Log-Normal distribution |
| Risk Metrics | EAL, VaR 95%, VaR 99%, VaR 99.5% (Solvency II) |
| Treaty Structures Analysed | 3 XL layers compared |
| Countries Covered | 20 countries, 1970–2014 |

---

## 📊 Key Visualisations

> OEP Curve | Frequency Model | Severity Model | Risk Heatmap | Decade Trends

---

## 🔧 Methodology

1. **Synthetic Dataset** — Built from real EM-DAT/NatCat anchors (Katrina $200B, Tohoku $235B, Haiti 220K deaths)
2. **SQL Analysis** — Risk tiering by country, decade trend analysis, top-10 deadliest countries
3. **Frequency Model** — Poisson distribution fitted to annual event counts
4. **Severity Model** — Log-Normal distribution fitted to loss magnitudes
5. **Monte Carlo** — 10,000 simulations of annual aggregate loss
6. **OEP Curve** — Occurrence Exceedance Probability for treaty pricing
7. **XL Treaty Analysis** — 3 reinsurance structures compared for risk transfer efficiency

---

## 💡 Key Insights

- Losses increasing decade-over-decade → premiums need trend loading
- Top 10 countries = 80%+ of global catastrophe mortality
- 1-in-100 year loss ≈ **4–5× the Expected Annual Loss** — heavy tail confirmed
- Solvency II capital (99.5th percentile) materially exceeds VaR 99%
- Higher retention structures transfer significantly less tail risk

---

## 🛠️ Tools & Technologies
`Python` `SQL` `SQLite` `SciPy` `NumPy` `Pandas` `Matplotlib` `Seaborn`

---

## 🗂️ Dataset
**Source:** Synthetic dataset anchored to published EM-DAT and Munich Re NatCat records  
**Real events included:** Bhola Cyclone, Tangshan, Katrina, Sichuan, Haiti, Tohoku, Haiyan  
**Architecture:** Identical to real HDX data — model is fully transferable

---

## 🚀 How to Run

```bash
git clone https://github.com/aryansinghal21-data/catastrophe-risk-modeling
cd catastrophe-risk-modeling
pip install -r requirements.txt
jupyter notebook notebooks/cat_risk_modeling.ipynb
```

> **Note:** Run **Kernel → Restart & Run All** to execute all cells in order.

---

## 📁 Project Structure

```
catastrophe-risk-modeling/
├── notebooks/
│   └── cat_risk_modeling.ipynb
├── sql/
│   └── cat_queries.sql
├── images/
│   └── (auto-generated charts)
├── data/
│   └── disaster_data.csv (auto-generated)
├── requirements.txt
└── README.md
```

---

## 👤 Author
**Aryan Singhal** | Aspiring Actuarial Data Analyst 
[LinkedIn](https://www.linkedin.com/in/aryansinghal21/) | [Email](mailto:aryansinghal821@gmail.com)
