/*
===============================================================================
Gold Layer: Business KPIs and Analytics Views
===============================================================================
Description:
    This script creates the analytical views in the 'gold' schema.
    The Gold Layer contains business-ready KPIs derived from the silver layer,
    designed to feed directly into Power BI dashboards.

Views:
    1. vw_failure_rate_by_product     - Failure rate by product type
    2. vw_failure_rate_by_type        - Failure rate by failure type
    3. vw_tool_wear_by_product        - Average tool wear by product type
    4. vw_oee_availability_by_product - OEE Availability by product type
    5. vw_operating_conditions        - Operating conditions during failure vs no failure
    6. vw_machine_risk_ranking        - Machine risk ranking by tool wear
===============================================================================
*/

-- ============================================================
-- 1. Failure Rate by Product Type
-- ============================================================
DROP VIEW IF EXISTS gold.vw_failure_rate_by_product;
GO
CREATE VIEW gold.vw_failure_rate_by_product AS
SELECT
    product_type,
    COUNT(*) AS total_machines,
    SUM(machine_failure) AS total_failures,
    ROUND(CAST(SUM(machine_failure) AS FLOAT) * 100 / COUNT(*), 2) AS failure_rate_pct
FROM silver.production_clean
GROUP BY product_type;
GO

-- ============================================================
-- 2. Failure Rate by Failure Type
-- ============================================================
DROP VIEW IF EXISTS gold.vw_failure_rate_by_type;
GO
CREATE VIEW gold.vw_failure_rate_by_type AS
SELECT 
    'TWF' AS failure_type, 
    SUM(twf) AS total_cases, 
    ROUND(CAST(SUM(twf) AS FLOAT) * 100 / COUNT(*), 2) AS pct_of_total_records,
    ROUND(CAST(SUM(twf) AS FLOAT) * 100 / (SELECT SUM(machine_failure) FROM silver.production_clean), 2) AS pct_of_total_failures
FROM silver.production_clean
UNION ALL
SELECT 'HDF', SUM(hdf), 
    ROUND(CAST(SUM(hdf) AS FLOAT) * 100 / COUNT(*), 2),
    ROUND(CAST(SUM(hdf) AS FLOAT) * 100 / (SELECT SUM(machine_failure) FROM silver.production_clean), 2)
FROM silver.production_clean
UNION ALL
SELECT 'PWF', SUM(pwf), 
    ROUND(CAST(SUM(pwf) AS FLOAT) * 100 / COUNT(*), 2),
    ROUND(CAST(SUM(pwf) AS FLOAT) * 100 / (SELECT SUM(machine_failure) FROM silver.production_clean), 2)
FROM silver.production_clean
UNION ALL
SELECT 'OSF', SUM(osf), 
    ROUND(CAST(SUM(osf) AS FLOAT) * 100 / COUNT(*), 2),
    ROUND(CAST(SUM(osf) AS FLOAT) * 100 / (SELECT SUM(machine_failure) FROM silver.production_clean), 2)
FROM silver.production_clean
UNION ALL
SELECT 'RNF', SUM(rnf), 
    ROUND(CAST(SUM(rnf) AS FLOAT) * 100 / COUNT(*), 2),
    ROUND(CAST(SUM(rnf) AS FLOAT) * 100 / (SELECT SUM(machine_failure) FROM silver.production_clean), 2)
FROM silver.production_clean;
GO

-- ============================================================
-- 3. Tool Wear by Product Type
-- ============================================================
DROP VIEW IF EXISTS gold.vw_tool_wear_by_product;
GO
CREATE VIEW gold.vw_tool_wear_by_product AS
SELECT
    product_type,
    ROUND(AVG(tool_wear_min), 2) AS avg_tool_wear_min
FROM silver.production_clean
GROUP BY product_type;
GO

-- ============================================================
-- 4. OEE Availability by Product Type
-- ============================================================
DROP VIEW IF EXISTS gold.vw_oee_availability_by_product;
GO
CREATE VIEW gold.vw_oee_availability_by_product AS
SELECT
    product_type,
    ROUND((1 - CAST(SUM(machine_failure) AS FLOAT) / COUNT(*)) * 100, 2) AS availability_pct
FROM silver.production_clean
GROUP BY product_type;
GO

-- ============================================================
-- 5. Operating Conditions: Failure vs No Failure
-- ============================================================
DROP VIEW IF EXISTS gold.vw_operating_conditions_by_failure;
GO
CREATE VIEW gold.vw_operating_conditions_by_failure AS
SELECT
    'air_temp_c' AS metric,
    ROUND(MIN(air_temp_c), 2) AS min_value,
    ROUND(MAX(air_temp_c), 2) AS max_value,
    ROUND(AVG(air_temp_c), 2) AS avg_value,
    machine_failure
FROM silver.production_clean
GROUP BY machine_failure
UNION ALL
SELECT 'process_temp_c',
    ROUND(MIN(process_temp_c), 2),
    ROUND(MAX(process_temp_c), 2),
    ROUND(AVG(process_temp_c), 2),
    machine_failure
FROM silver.production_clean
GROUP BY machine_failure
UNION ALL
SELECT 'rotational_speed_rpm',
    ROUND(MIN(rotational_speed_rpm), 2),
    ROUND(MAX(rotational_speed_rpm), 2),
    ROUND(AVG(rotational_speed_rpm), 2),
    machine_failure
FROM silver.production_clean
GROUP BY machine_failure
UNION ALL
SELECT 'torque_nm',
    ROUND(MIN(torque_nm), 2),
    ROUND(MAX(torque_nm), 2),
    ROUND(AVG(torque_nm), 2),
    machine_failure
FROM silver.production_clean
GROUP BY machine_failure
UNION ALL
SELECT 'tool_wear_min',
    ROUND(MIN(tool_wear_min), 2),
    ROUND(MAX(tool_wear_min), 2),
    ROUND(AVG(tool_wear_min), 2),
    machine_failure
FROM silver.production_clean
GROUP BY machine_failure;
GO

-- ============================================================
-- 6. Machine Risk Ranking
-- ============================================================
DROP VIEW IF EXISTS gold.vw_machine_risk_ranking;
GO
CREATE VIEW gold.vw_machine_risk_ranking AS
SELECT
    machine_id,
    tool_wear_min,
    machine_failure,
    ROW_NUMBER() OVER (ORDER BY tool_wear_min DESC) AS risk_rank,
    NTILE(4) OVER (ORDER BY tool_wear_min DESC) AS risk_tier
FROM silver.production_clean;
GO
