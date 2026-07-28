# ☕ Bright Coffee Shop - Sales Performance Analysis

## Project Overview
This project analyzes 6 months of transactional sales data (January - June 2023) from Bright Coffee Shop. The goal was to help the new CEO understand revenue drivers, product performance, and peak trading times to make data-driven decisions.

**Status:** Complete ✅  
**Author:** Siyakha Ntuli  
**Date:** July 2026  
**Data Source:** Verified Against Source Data

---

## Key Metrics (Verified Data)

| Metric | Value |
|--------|-------|
| Total Revenue | $623,586 |
| Total Transactions | 149,116 |
| Average Transaction Value | $4.18 |
| Total Units Sold | 214,470 |
| Average Units per Transaction | 1.44 |
| Growth (Feb-Jun) | 119% |
| Growth (Jan-Jun) | 103.8% |
| Peak Time | 10:30 AM ($40,051) |
| Slowest Time | 8:00 PM ($1,181) |

---

## ⚠️ Critical Data Quality Issue

| Issue | Impact |
|-------|--------|
| **70.5%** of rows (105,078) missing product category | Category-level analysis limited |
| **63.5%** of revenue ($395,746) classified as "Not Provided" | Product insights incomplete |
| Only **36.5%** of revenue ($227,840) attributable to known categories | Recommendations limited |

**Recommendation:** Fix source data with engineering team as top priority.

---

## Project Structure

```

bright-coffee-shop-analysis/
│
├── README.md                                      ← This file
├── Project_Description.md                         ← Detailed project description
│
├── 01_Raw_Data/
│   └── bright_coffee_shop_raw.csv                 ← Original dataset (149,116 rows)
│
├── 02_Processed_Data/
│   └── coffee_sales_processed.csv                 ← Cleaned data with new columns
│
├── 03_SQL_Queries/
│   └── analysis_queries.sql                       ← All SQL analysis queries
│
├── 04_Dashboards/
│   ├── Databricks/                                ← Databricks dashboard
│   ├── PowerBI/                                   ← Power BI dashboard (.pbix)
│   ├── LookerStudio/                              ← Looker Studio dashboard
│   ├── Lovable/                                   ← Lovable dashboard
│   └── Excel/                                     ← Excel pivot tables (.xlsx)
│
├── 05_Presentation/
│   └── Bright_Coffee_CEO_Presentation.pptx        ← CEO PowerPoint (13 slides)
│
└── 06_Documentation/
├── Project_Workflow/                          ← Draw.io workflow diagram
├── Project_Overview/                          ← Draw.io overview diagram
├── Data_Dictionary.md                         ← Column descriptions
└── Methodology.md                             ← Project approach

```

---

## Tools Used

| Tool | Purpose |
|------|---------|
| **Databricks** | Data processing, cleaning, and transformation |
| **SQL** | Data exploration and analysis queries |
| **Power BI** | Interactive dashboard (2 pages) |
| **Looker Studio** | Interactive dashboard (2 pages) |
| **Lovable** | Interactive dashboard (2 pages) |
| **Excel** | Pivot tables (8 sheets) and charts |
| **Draw.io** | Project planning boards |
| **PowerPoint** | CEO presentation (13 slides) |

---

## Dashboards

### Page 1: Executive Overview
- 3 KPI Cards (Revenue, Transactions, Avg Value)
- 2 Slicers (Month, Product Category)
- Revenue by Product Category (Bar Chart)
- Revenue by 30-Minute Time Bucket (Column Chart)

### Page 2: Product & Time Analysis
- 2 KPI Cards (Units Sold, Avg Units per Transaction)
- 2 Slicers (Store Location, Product Type)
- Revenue by Day of Week (Column Chart)
- Revenue by Product Type (Stacked Column Chart)
- Top 10 Best-Selling Products (Bar Chart)
- Bottom 10 Underperforming Products (Bar Chart)

---

## Key Findings

### Revenue by Category (Known Only)
| Category | Revenue | % of Known |
|----------|---------|------------|
| Tea | $93,545 | 41.1% |
| Coffee | $87,569 | 38.4% |
| Coffee Beans | $26,740 | 11.7% |
| Branded | $14,526 | 6.4% |
| Bakery | $5,460 | 2.4% |

### Monthly Revenue Trend
| Month | Revenue | Change |
|-------|---------|--------|
| January | $72,970 | - |
| February | $67,864 | -7.0% |
| March | $88,143 | +29.9% |
| April | $106,173 | +20.5% |
| May | $139,748 | +31.6% |
| June | $148,688 | +6.4% |

**Insight:** Revenue grew 119% from February (low point) to June.

### Top 5 Products
| Rank | Product | Revenue |
|------|---------|---------|
| 1 | Gourmet Brewed Coffee | $34,120 |
| 2 | Brewed Chai Tea | $31,450 |
| 3 | Brewed Black Coffee | $27,890 |
| 4 | Brewed Herbal Tea | $24,340 |
| 5 | Drip Coffee | $21,670 |

### Bottom 5 Products
| Rank | Product | Revenue |
|------|---------|---------|
| 1 | Green Beans | $1,340 |
| 2 | House Blend | $2,150 |
| 3 | Organic Beans | $3,210 |
| 4 | Croissant | $4,320 |
| 5 | Muffin | $5,450 |

### Store Performance
| Rank | Store | Units Sold | Difference |
|------|-------|------------|------------|
| 🥇 | Lower Manhattan | 71,742 | - |
| 🥈 | Hell's Kitchen | 71,737 | -5 |
| 🥉 | Astoria | 70,991 | -751 |

---

## Recommendations

### 1. Data Quality (Priority)
- Investigate source system with data engineering team
- Implement mandatory product hierarchy at POS
- Backfill historical data if possible

### 2. Staffing Optimization
- Increase staff 10:00 AM - 11:00 AM (Peak: $40,051)
- Reduce staff 7:00 PM - 8:00 PM (Lowest: $1,181)
- Maintain morning staff 8:00 AM - 9:00 AM

### 3. Inventory Management
- Stock more Gourmet Brewed Coffee (Top: $34,120)
- Stock more Brewed Chai Tea (Second: $31,450)
- Reduce Coffee Beans stock (Bottom performers)
- Review Bakery offerings ($5,460 only)

### 4. Marketing & Promotions
- Bundle Green Beans with Gourmet Coffee
- Evening promotions to boost slow period
- Loyalty program with double points during slow hours
- Saturday promotions (busiest day)

---

## Deliverables

| Deliverable | Location |
|-------------|----------|
| Project Description | `Project_Description.md` |
| Raw Data | `01_Raw_Data/` |
| Processed Data | `02_Processed_Data/` |
| SQL Queries | `03_SQL_Queries/` |
| Power BI Dashboard | `04_Dashboards/PowerBI/` |
| Looker Studio Dashboard | `04_Dashboards/LookerStudio/` |
| Lovable Dashboard | `04_Dashboards/Lovable/` |
| Databricks Dashboard | `04_Dashboards/Databricks/` |
| Excel Pivot Tables | `04_Dashboards/Excel/` |
| CEO Presentation | `05_Presentation/` |
| Planning Diagrams | `06_Documentation/` |
| Data Dictionary | `06_Documentation/Data_Dictionary.md` |
| Methodology | `06_Documentation/Methodology.md` |

---

## Planning Diagrams

### Project Workflow
[View Workflow Diagram](https://drive.google.com/file/d/1eM2LAlXkANxti66U3Ta35vLUqKQ0o9KZ/view?usp=sharing)

### Project Overview
[View Overview Diagram](https://drive.google.com/file/d/1eM2LAlXkANxti66U3Ta35vLUqKQ0o9KZ/view?usp=sharing)



## Next Steps

| Week | Action |
|------|--------|
| Week 1 | Data Quality - Schedule meeting with engineering team |
| Week 2 | Staffing - Adjust schedules to match peak times |
| Week 3 | Inventory - Increase stock of top products |
| Week 4 | Marketing - Launch evening promotions and bundling deals |
| Ongoing | Store Review - Review Astoria operations and share best practices |



## Author
**Siyakha Ntuli**  
Junior Data Analyst  
July 2026

---
