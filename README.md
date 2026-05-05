# 🛍️ Customer Shopping Behaviour Analysis

<img width="1339" height="729" alt="image" src="https://github.com/user-attachments/assets/bdfa066e-1af5-49b4-be4a-50003c1472c3" />
<img width="1052" height="580" alt="image" src="https://github.com/user-attachments/assets/d7e71f7d-5227-4bca-bcac-74715aca9b53" />



## 📌 Overview

This is an end-to-end data analytics project analyzing customer shopping behaviour to uncover insights around **revenue trends, customer segmentation, product performance, and subscription patterns**.

Resolved missing values using category-wise median imputation to improve data accuracy, engineered new features (age_group and purchase_frequency_days) for enhanced customer segmentation and behavioral insights, identified and removed redundant duplicate columns to ensure data quality, and developed an automated Python-to-PostgreSQL data pipeline using SQLAlchemy for efficient cloud-based data ingestion.

---

## 📂 Dataset

| Detail | Info |
|---|---|
| **File** | `customer_shopping_behavior.csv` |
| **Rows** | 3,900 customers |
| **Columns** | 18 features |
| **Source** | Kaggle / Synthetic retail dataset |

**Key Columns:**
`Customer ID`, `Age`, `Gender`, `Item Purchased`, `Category`, `Purchase Amount (USD)`, `Location`, `Season`, `Review Rating`, `Subscription Status`, `Shipping Type`, `Discount Applied`, `Previous Purchases`, `Frequency of Purchases`, `Payment Method`

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python (Pandas, NumPy)** | Data loading, EDA, cleaning |
| **Google Colab** | Python notebook environment |
| **PostgreSQL (Neon)** | Cloud database & SQL analysis |
| **SQLAlchemy** | Python to PostgreSQL connection |
| **Power BI** | Interactive dashboard |

---

### 1️⃣ Data Loading & Exploration (Python)
- Loaded dataset using `pandas`
- Explored shape, data types, and summary statistics with `.info()`, `.describe()`
- Identified null values in the `Review Rating` column

### 2️⃣ Data Cleaning (Python)
- **Handled nulls** — filled missing `Review Rating` values with category-wise median
- **Standardized columns** — lowercased and replaced spaces with underscores
- **Renamed columns** — `purchase_amount_(usd)` → `purchase_amount`
- **Created new features:**
  - `age_group` — segmented age into `Young Adult`, `Adult`, `Middle-aged`, `Senior` using `pd.qcut()`
  - `purchase_frequency_days` — mapped frequency labels to numeric days (e.g., Weekly → 7, Monthly → 30)
- **Removed duplicate column** — dropped `promo_code_used` (identical to `discount_applied`)

### 3️⃣ Database Upload (Python → Neon PostgreSQL)
- Connected to **Neon cloud PostgreSQL** using `SQLAlchemy`
- Uploaded cleaned DataFrame directly to the `customer` table

### 4️⃣ SQL Analysis (PostgreSQL)
Ran 12 analytical queries covering:

| # | Analysis |
|---|---|
| 1 | Revenue by Gender |
| 2 | High-value customers with discounts (subquery) |
| 3 | Top 5 products by average review rating |
| 4 | Average spend by shipping type |
| 5 | Subscription status distribution |
| 6 | Revenue & avg spend by subscription status |
| 7 | Top 5 items by discount rate |
| 8 | Customer segmentation — New / Returning / Loyal (CTE) |
| 9 | Top 3 items per category (Window Function) |
| 10 | Loyal subscribers with 5+ purchases |
| 11 | Repeat buyers by subscription status |
| 12 | Revenue by age group |

### 5️⃣ Power BI Dashboard
- Imported cleaned data into Power BI
- Built interactive visuals for revenue, segmentation, product performance and subscriptions
- Added slicers for filtering by gender, season, category, and subscription status



## 📊 Dashboard Preview

**Dashboard includes:**
- 💰 Revenue by Gender & Age Group
- 📦 Top Products by Rating & Sales
- 🔁 Subscription vs Non-Subscription Spend
- 🚚 Shipping Type Analysis
- 👥 Customer Segmentation (New / Returning / Loyal)
- 📊 Top 10 Items Purchased (Bar Chart)
- 🗺️ Top 10 States by Orders (Map Visual)
- 📅 Season vs Revenue (Bar Chart)
---

## 📈 Key Results & Insights

- 👗 **Clothing** is the highest revenue-generating category
- 💳 **Subscribed customers** spend significantly more on average
- 🔖 Certain items have **high discount rates** but still maintain strong ratings
- 👴 **Middle-aged customers** contribute the most revenue by age group
- 🔄 A large portion of customers are **Loyal** (10+ previous purchases)
- 📦 **Standard and Express** shipping types dominate order volume


```

