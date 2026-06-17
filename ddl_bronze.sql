/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Description:
    This script creates the table in the 'bronze' schema.
    The Bronze Layer is the Landing Zone for raw data ingested directly
    from the source (Kaggle AI4I 2020 Predictive Maintenance Dataset)
    without any transformations, preserving the original data structure.

Run this script before: load_bronze.sql
===============================================================================
*/

IF OBJECT_ID('bronze.production_raw', 'U') IS NOT NULL
    DROP TABLE bronze.production_raw;

CREATE TABLE bronze.production_raw (
    UDI                     INT,
    Product_ID              NVARCHAR(50),
    Type                    NVARCHAR(10),
    Air_temperature_K       FLOAT,
    Process_temperature_K   FLOAT,
    Rotational_speed_rpm    INT,
    Torque_Nm               FLOAT,
    Tool_wear_min           INT,
    Machine_failure         INT,
    TWF                     INT,
    HDF                     INT,
    PWF                     INT,
    OSF                     INT,
    RNF                     INT
);