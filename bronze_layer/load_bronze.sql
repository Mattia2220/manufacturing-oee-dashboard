/*
===============================================================================
Load Script: Populate Bronze Table
===============================================================================
Description:
    This script loads raw data into the bronze.production_raw table
    using BULK INSERT from the source CSV file.

    Source: AI4I 2020 Predictive Maintenance Dataset (Kaggle)
    Target: bronze.production_raw

    Note: Update the file path before running.
===============================================================================
*/

BULK INSERT bronze.production_raw
FROM 'C:\Users\TuoNome\Downloads\ai4i2020.csv'  -- aggiorna il percorso
WITH (
    FIRSTROW = 2,           -- salta la riga di intestazione
    FIELDTERMINATOR = ',',  -- separatore CSV
    ROWTERMINATOR = '\n',   -- a capo
    TABLOCK
);