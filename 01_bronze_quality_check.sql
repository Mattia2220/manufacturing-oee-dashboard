/*
===============================================================================
Quality Check: Bronze Layer
===============================================================================
Description:
    This script performs data quality checks on the bronze.production_raw table.
    Checks include:
    - NULL values on all columns
    - Duplicate records based on UDI
    - Outlier detection on numerical columns
    - Distribution of categorical column 'Type'
===============================================================================
*/

-- ============================================================
-- 1. NULL Check
-- ============================================================
SELECT 
    SUM(CASE WHEN [UDI] IS NULL THEN 1 ELSE 0 END) AS null_udi,
    SUM(CASE WHEN [Product_ID] IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN [Type] IS NULL THEN 1 ELSE 0 END) AS null_type,
    SUM(CASE WHEN [Air_temperature_K] IS NULL THEN 1 ELSE 0 END) AS null_air_temp,
    SUM(CASE WHEN [Process_temperature_K] IS NULL THEN 1 ELSE 0 END) AS null_process_temp,
    SUM(CASE WHEN [Rotational_speed_rpm] IS NULL THEN 1 ELSE 0 END) AS null_rpm,
    SUM(CASE WHEN [Torque_Nm] IS NULL THEN 1 ELSE 0 END) AS null_torque,
    SUM(CASE WHEN [Tool_wear_min] IS NULL THEN 1 ELSE 0 END) AS null_tool_wear,
    SUM(CASE WHEN [Machine_failure] IS NULL THEN 1 ELSE 0 END) AS null_failure,
    SUM(CASE WHEN [TWF] IS NULL THEN 1 ELSE 0 END) AS null_TWF,
    SUM(CASE WHEN [HDF] IS NULL THEN 1 ELSE 0 END) AS null_HDF,
    SUM(CASE WHEN [PWF] IS NULL THEN 1 ELSE 0 END) AS null_PWF,
    SUM(CASE WHEN [OSF] IS NULL THEN 1 ELSE 0 END) AS null_OSF,
    SUM(CASE WHEN [RNF] IS NULL THEN 1 ELSE 0 END) AS null_RNF
FROM bronze.production_raw;

-- ============================================================
-- 2. Duplicate Check
-- ============================================================
SELECT 
    UDI,
    COUNT(*) AS occorrenze
FROM bronze.production_raw
GROUP BY UDI
HAVING COUNT(*) > 1;

-- ============================================================
-- 3. Outlier Check (numerical columns)
-- ============================================================
SELECT 
    MAX([Air_temperature_K]) AS max_air_temp,
    MIN([Air_temperature_K]) AS min_air_temp,
    AVG([Air_temperature_K]) AS avg_air_temp,

    MAX([Process_temperature_K]) AS max_process_temp,
    MIN([Process_temperature_K]) AS min_process_temp,
    AVG([Process_temperature_K]) AS avg_process_temp,

    MAX([Rotational_speed_rpm]) AS max_rpm,
    MIN([Rotational_speed_rpm]) AS min_rpm,
    AVG([Rotational_speed_rpm]) AS avg_rpm,

    MAX([Torque_Nm]) AS max_torque,
    MIN([Torque_Nm]) AS min_torque,
    AVG([Torque_Nm]) AS avg_torque,

    MAX([Tool_wear_min]) AS max_tool_wear,
    MIN([Tool_wear_min]) AS min_tool_wear,
    AVG([Tool_wear_min]) AS avg_tool_wear
FROM bronze.production_raw;

-- ============================================================
-- 4. Categorical Distribution Check
-- ============================================================
SELECT
    Type,
    COUNT(Type) AS count_type
FROM bronze.production_raw
GROUP BY Type;