/*
===============================================================================
Setup Script: Database and Schema Initialization
===============================================================================
Description:
    This script creates the database and the three schemas following
    the Medallion Architecture pattern (Bronze, Silver, Gold).

    - Bronze: Raw data, no transformations
    - Silver: Cleaned and standardized data
    - Gold: Business-ready KPIs for reporting

    It also creates the bronze.production_raw table and loads
    the raw data from the source CSV file.
===============================================================================
*/

-- Crea il database
CREATE DATABASE ManufacturingOEE;
GO

USE ManufacturingOEE;
GO

-- Crea i tre schemi
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

-- Crea la tabella bronze
CREATE TABLE bronze.production_raw (
    UDI                   INT,
    Product_ID            NVARCHAR(50),
    Type                  NVARCHAR(10),
    Air_temperature_K     FLOAT,
    Process_temperature_K FLOAT,
    Rotational_speed_rpm  INT,
    Torque_Nm             FLOAT,
    Tool_wear_min         INT,
    Machine_failure       INT,
    TWF                   INT,
    HDF                   INT,
    PWF                   INT,
    OSF                   INT,
    RNF                   INT
);

-- Carica i dati dal CSV
BULK INSERT bronze.production_raw
FROM 'C:\Users\TuoNome\Downloads\ai4i2020.csv'  -- aggiorna il percorso
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
