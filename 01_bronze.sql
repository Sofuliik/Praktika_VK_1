CREATE SCHEMA IF NOT EXISTS bronze.lakehouse;
CREATE SCHEMA IF NOT EXISTS silver.lakehouse;
CREATE SCHEMA IF NOT EXISTS gold.lakehouse;

CREATE TABLE bronze.lakehouse.customer
WITH (location = 's3://bronze/lakehouse/customer/')
AS SELECT * FROM tpch.sf1.customer;

CREATE TABLE bronze.lakehouse.orders
WITH (location = 's3://bronze/lakehouse/orders/')
AS SELECT * FROM tpch.sf1.orders;


SELECT 'customer' AS tbl, count(*) FROM bronze.lakehouse.customer
UNION ALL
SELECT 'orders', count(*) FROM bronze.lakehouse.orders;
