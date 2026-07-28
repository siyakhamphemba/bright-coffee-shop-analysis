-- Databricks notebook source
-- ============================================================
-- BRIGHT COFFEE SHOP - SALES PERFORMANCE ANALYSIS
-- Author: Siyakha Ntuli
-- Date: July 2026
-- Purpose: Analyse transactional sales data to provide
--          insights on revenue drivers, product performance,
--          and peak trading times for the CEO
-- ============================================================

-- ============================================================
-- SECTION 1: DATA EXPLORATION
-- Purpose: Understand the structure and content of raw tables
--          before any transformation or analysis
-- ============================================================

-- 1.1 Inspect column names and data types
DESCRIBE retail.default.bright_coffee_shop_sales;

-- 1.2 Check date range of the data
SELECT 
    MIN(transaction_date) AS first_transaction_date,
    MAX(transaction_date) AS last_transaction_date,
    DATEDIFF(MAX(transaction_date), MIN(transaction_date)) AS days_of_data
FROM retail.default.bright_coffee_shop_sales;

-- 1.3 See all distinct store locations
SELECT DISTINCT store_location 
FROM retail.default.bright_coffee_shop_sales
ORDER BY store_location;

-- 1.4 See all product categories
SELECT DISTINCT product_category 
FROM retail.default.bright_coffee_shop_sales
WHERE product_category IS NOT NULL AND product_category != ''
ORDER BY product_category;

-- 1.5 See all product types
SELECT DISTINCT product_type 
FROM retail.default.bright_coffee_shop_sales
WHERE product_type IS NOT NULL AND product_type != ''
ORDER BY product_type;

-- 1.6 See all product details
SELECT DISTINCT product_detail 
FROM retail.default.bright_coffee_shop_sales
WHERE product_detail IS NOT NULL AND product_detail != ''
ORDER BY product_detail;

-- 1.7 Check earliest and latest transaction times
SELECT 
    MIN(transaction_time) AS earliest_transaction,
    MAX(transaction_time) AS latest_transaction
FROM retail.default.bright_coffee_shop_sales;

-- 1.8 Count distinct values
SELECT 
    COUNT(DISTINCT store_location) AS distinct_stores,
    COUNT(DISTINCT product_id) AS distinct_products,
    COUNT(DISTINCT product_category) AS distinct_categories,
    COUNT(DISTINCT product_type) AS distinct_types,
    COUNT(DISTINCT product_detail) AS distinct_details
FROM retail.default.bright_coffee_shop_sales;

-- ============================================================
-- SECTION 2: KEY PERFORMANCE INDICATORS (KPIs)
-- Purpose: Calculate main business metrics for executive summary
-- ============================================================

-- 2.1 Get main KPIs: revenue, transactions, average values
SELECT 
    SUM(transaction_qty) AS total_units_sold,
    SUM(transaction_qty * unit_price) AS total_revenue,
    COUNT(*) AS total_transactions,
    ROUND(AVG(transaction_qty * unit_price), 2) AS avg_transaction_value,
    ROUND(SUM(transaction_qty) * 1.0 / COUNT(*), 2) AS avg_units_per_transaction,
    MIN(transaction_qty) AS min_quantity,
    MAX(transaction_qty) AS max_quantity
FROM retail.default.bright_coffee_shop_sales;

-- ============================================================
-- SECTION 3: DATA QUALITY CHECKS
-- Purpose: Identify data quality issues that need fixing
-- ============================================================

-- 3.1 Check for null values in all columns
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS null_transaction_date,
    SUM(CASE WHEN transaction_time IS NULL THEN 1 ELSE 0 END) AS null_transaction_time,
    SUM(CASE WHEN transaction_qty IS NULL THEN 1 ELSE 0 END) AS null_transaction_qty,
    SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) AS null_store_id,
    SUM(CASE WHEN store_location IS NULL THEN 1 ELSE 0 END) AS null_store_location,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS null_unit_price,
    SUM(CASE WHEN product_category IS NULL OR product_category = '' THEN 1 ELSE 0 END) AS null_or_blank_category,
    SUM(CASE WHEN product_type IS NULL OR product_type = '' THEN 1 ELSE 0 END) AS null_or_blank_type,
    SUM(CASE WHEN product_detail IS NULL OR product_detail = '' THEN 1 ELSE 0 END) AS null_or_blank_detail
FROM retail.default.bright_coffee_shop_sales;

-- 3.2 Check percentage of blanks in category, type, detail
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN product_category = '' OR product_category IS NULL THEN 1 ELSE 0 END) AS blank_category,
    SUM(CASE WHEN product_type = '' OR product_type IS NULL THEN 1 ELSE 0 END) AS blank_type,
    SUM(CASE WHEN product_detail = '' OR product_detail IS NULL THEN 1 ELSE 0 END) AS blank_detail,
    ROUND(SUM(CASE WHEN product_category = '' OR product_category IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS category_blank_percent,
    ROUND(SUM(CASE WHEN product_type = '' OR product_type IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS type_blank_percent,
    ROUND(SUM(CASE WHEN product_detail = '' OR product_detail IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS detail_blank_percent
FROM retail.default.bright_coffee_shop_sales;

-- 3.3 Check if unit_price has commas instead of dots (e.g., 3,1 instead of 3.1)
SELECT DISTINCT unit_price
FROM retail.default.bright_coffee_shop_sales
WHERE unit_price LIKE '%,%'
LIMIT 20;

-- 3.4 Check data type of unit_price
SELECT 
    unit_price,
    TYPEOF(unit_price) AS data_type
FROM retail.default.bright_coffee_shop_sales
LIMIT 5;

-- 3.5 Investigate which products have blank category
SELECT 
    product_id,
    COUNT(*) AS transaction_count,
    COUNT(DISTINCT product_category) AS distinct_categories,
    COLLECT_SET(product_category) AS category_values
FROM retail.default.bright_coffee_shop_sales
WHERE product_category = '' OR product_category IS NULL
GROUP BY product_id
ORDER BY transaction_count DESC;

-- ============================================================
-- SECTION 4: DATA CLEANING (CREATE VIEW FOR POWER BI)
-- Purpose: Fill blank product hierarchy values with 'Not Provided'
--          so analysis can run on all transactions without losing data
--          Data quality issue: 70.5% of rows missing product hierarchy
--          This should be raised with data engineering team
-- 
--          THIS VIEW WILL BE CONNECTED TO POWER BI
-- ============================================================

CREATE OR REPLACE VIEW retail.default.coffee_sales_cleaned AS
SELECT 
    transaction_id,
    transaction_date,
    transaction_time,
    transaction_qty,
    store_id,
    store_location,
    product_id,
    unit_price,
    
    -- Fill blanks with 'Not Provided'
    CASE 
        WHEN product_category IS NULL OR product_category = '' THEN 'Not Provided'
        ELSE product_category
    END AS product_category,
    
    CASE 
        WHEN product_type IS NULL OR product_type = '' THEN 'Not Provided'
        ELSE product_type
    END AS product_type,
    
    CASE 
        WHEN product_detail IS NULL OR product_detail = '' THEN 'Not Provided'
        ELSE product_detail
    END AS product_detail,
    
    -- Calculate total amount
    ROUND(transaction_qty * unit_price, 2) AS total_amount

FROM retail.default.bright_coffee_shop_sales;

-- 4.1 Verify the view
SELECT 
    product_category,
    COUNT(*) AS transaction_count,
    SUM(total_amount) AS revenue
FROM retail.default.coffee_sales_cleaned
GROUP BY product_category
ORDER BY transaction_count DESC;

-- 4.2 Check total rows in view (should match original)
SELECT 
    COUNT(*) AS total_rows_in_view
FROM retail.default.coffee_sales_cleaned;