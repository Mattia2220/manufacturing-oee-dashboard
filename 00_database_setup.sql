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

Note:
    Run this script only on a fresh environment.
    Database and schemas are already initialized in the current instance.
===============================================================================
*/

CREATE DATABASE ManufacturingOEE;
GO

USE ManufacturingOEE;
GO

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO