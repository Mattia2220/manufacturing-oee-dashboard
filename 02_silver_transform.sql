/*
===============================================================================
Transform Script: Silver Layer
===============================================================================
Description:
    This script creates the silver.production_clean table by applying
    the following transformations to the bronze.production_raw table:
    - Renaming columns for readability
    - Converting temperatures from Kelvin to Celsius
    - Expanding Type codes (L/M/H) to full labels (Low/Medium/High)
===============================================================================
*/

IF OBJECT_ID('silver.production_clean', 'U') IS NOT NULL
    DROP TABLE silver.production_clean;

SELECT
    UDI AS machine_id,
    Product_ID AS product_id,
    CASE 
        WHEN Type = 'H' THEN 'High'
        WHEN Type = 'M' THEN 'Medium'
        ELSE 'Low'
    END AS product_type,
    Air_temperature_K - 273.15 AS air_temp_c,
    Process_temperature_K - 273.15 AS process_temp_c,
    Rotational_speed_rpm AS rotational_speed_rpm,
    Torque_Nm AS torque_nm,
    Tool_wear_min AS tool_wear_min,
    Machine_failure AS machine_failure,
    TWF AS twf,
    HDF AS hdf,
    PWF AS pwf,
    OSF AS osf,
    RNF AS rnf

INTO silver.production_clean
FROM bronze.production_raw;