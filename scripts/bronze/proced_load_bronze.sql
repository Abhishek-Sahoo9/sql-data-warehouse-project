/*
===========================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
===========================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external csv files.
    It performs the following actions:
      - Truncates the bronze tables before loadin data.
      - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters :
    None.
    This stored procedure does not accept any parameters or return any values.

*/

-- Create Stored Procedure

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @startTime DATETIME, @endTime DATETIME;
	DECLARE @batch_startTime DATETIME, @batch_endTime DATETIME;    -- For calculating the time taken to load the whole Bronze layer
	BEGIN TRY
		
		SET @batch_startTime = GETDATE();
		PRINT '=========================';
		PRINT 'Loading BRONZE Layer';
		PRINT '=========================';

		PRINT '-------------------------';
		PRINT 'Loading CRP Tables';
		PRINT '-------------------------';

		-- Develop SQL Load Scripts (BULK INSERT)

		SET @startTime = GETDATE();
		PRINT '## Truncating Table : bronze.crm_cust_info';

		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '## Inserting Data into : bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT * FROM bronze.crm_cust_info;
		SET @endTime = GETDATE();
		PRINT'>> Load duration : ' + CAST (DATEDIFF(second, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT'******************************';

		SET @startTime = GETDATE();
		PRINT '## Truncating Table : bronze.crm_prd_info';

		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '## Inserting Data into : bronze.crm_prd_info';

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT * FROM bronze.crm_prd_info;
		SET @endTime = GETDATE();
		PRINT'>> Load duration : ' + CAST (DATEDIFF(second, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT'******************************';

		SET @startTime = GETDATE();
		PRINT '## Truncating Table : bronze.crm_sales_details';

		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '## Inserting Data into : bronze.crm_sales_details';

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT * FROM bronze.crm_sales_details
		SET @endTime = GETDATE();
		PRINT'>> Load duration : ' + CAST (DATEDIFF(second, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT'******************************';

		PRINT '-------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '-------------------------'

		SET @startTime = GETDATE();
		PRINT '## Truncating Table : bronze.erp_cust_az12';

		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '## Inserting Data into : bronze.erp_cust_az12';

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT * FROM bronze.erp_cust_az12
		SET @endTime = GETDATE();
		PRINT'>> Load duration : ' + CAST (DATEDIFF(second, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT'******************************';

		SET @startTime = GETDATE();
		PRINT '## Truncating Table : bronze.erp_loc_a101';

		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '## Inserting Data into : bronze.erp_loc_a101';

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT  * FROM bronze.erp_loc_a101
		SET @endTime = GETDATE();
		PRINT'>> Load duration : ' + CAST (DATEDIFF(second, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT'******************************';

		SET @startTime = GETDATE();
		PRINT '## Truncating Table : bronze.erp_px_cat_g1v2';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '## Inserting Data into : bronze.erp_px_cat_g1v2';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT * FROM bronze.erp_px_cat_g1v2
		SET @endTime = GETDATE();
		PRINT'>> Load duration : ' + CAST (DATEDIFF(second, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT'******************************';


		SET @batch_endTime = GETDATE();
		PRINT'>> Load duration of the layer : ' + CAST (DATEDIFF(second, @batch_startTime, @batch_endTime) AS NVARCHAR) + ' seconds';
		PRINT 'Loading Bronze layer is completed.'
		PRINT'******************************';

	END TRY
	BEGIN CATCH
		PRINT '-------------------------------------------'
		PRINT 'Error occured during executing BRONZE layer'
		PRINT 'Error Message : '+ ERROR_MESSAGE();
		PRINT '-------------------------------------------'
	END CATCH
END

EXEC bronze.load_bronze
