# 🏭 Manufacturing OEE Dashboard

## Project Overview
End-to-end data analysis project simulating a real-world manufacturing analytics scenario.
The goal is to identify the root causes of equipment failures, monitor OEE (Overall Equipment Effectiveness) 
and provide actionable insights to plant management through a Power BI dashboard.

---

## Business Context
A manufacturing plant with multiple production lines is experiencing a decline in equipment efficiency.
As a Data Analyst, the objective is to:
- Identify which product types have the highest failure rates
- Understand which failure modes are most critical
- Monitor tool wear progression and machine risk levels
- Provide a dashboard for data-driven operational decisions

---

## Tech Stack
| Tool | Purpose |
|---|---|
| SQL Server | Data storage and transformation |
| SSMS | Query development and execution |
| Power BI | Dashboard and data visualization |
| GitHub | Version control and portfolio |

---

## Architecture: Medallion Pattern
The project follows the **Medallion Architecture** (Bronze → Silver → Gold):

Bronze Layer  →  Raw data ingested from source (no transformations)

Silver Layer  →  Cleaned and standardized data (renamed columns, Kelvin to Celsius conversion)

Gold Layer    →  Business-ready KPIs and analytical views for Power BI

---

## Dataset
**AI4I 2020 Predictive Maintenance Dataset**
- Source: [Kaggle](https://www.kaggle.com/datasets/stephanmatzka/predictive-maintenance-dataset-ai4i-2020)
- 10,000 records of industrial machine operational data
- Features: air temperature, process temperature, rotational speed, torque, tool wear, failure types

---

## SQL Scripts
| File | Description |
|---|---|
| `00_database_setup.sql` | Database creation, schema initialization, raw data ingestion |
| `01_bronze_quality_check.sql` | Data quality checks: nulls, duplicates, outliers, distributions |
| `02_silver_transform.sql` | Data cleaning and standardization |
| `03_gold_kpi.sql` | Business KPI views for Power BI |

---

## KPIs Analyzed
- **Failure Rate by Product Type** — which product category fails most
- **Failure Rate by Failure Mode** — TWF, HDF, PWF, OSF, RNF breakdown
- **OEE Availability** — uptime percentage by product type
- **Tool Wear Analysis** — average wear by product type
- **Operating Conditions** — temperature, speed, torque during failure vs no failure
- **Machine Risk Ranking** — machines ranked and tiered by failure risk

---

## Key Findings
- **Low** quality products have the highest failure rate (3.92%) despite being the most produced
- **HDF (Heat Dissipation Failure)** is the most common failure mode (33.92% of all failures)
- **OEE Availability** ranges from 96.08% (Low) to 97.91% (High) across product types
- Machines that fail show significantly higher average torque (50.17 Nm vs 39.63 Nm)
- Tool wear is on average 35% higher in failed machines (143 min vs 106 min)

---

## Power BI Dashboard
*Coming soon — dashboard will connect directly to Gold Layer views via SQL Server connection.*

---

## Author
**Mattia Falco**
- LinkedIn: www.linkedin.com/in/mattia-falco-4b8b3033b 
- GitHub: https://github.com/Mattia2220/manufacturing-oee-dashboard
