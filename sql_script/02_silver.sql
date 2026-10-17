CREATE TABLE silver.lakehouse.orders_cleaned AS
SELECT orderkey, custkey, orderdate, totalprice
FROM bronze.lakehouse.orders;

CREATE TABLE silver.lakehouse.customer_cleaned AS
SELECT custkey, name
FROM bronze.lakehouse.customer;

CREATE TABLE silver.lakehouse.orders_zstd AS
SELECT * FROM bronze.lakehouse.orders;

CREATE TABLE silver.lakehouse.orders_gzip AS
SELECT * FROM bronze.lakehouse.orders;

SHOW TABLES FROM silver.lakehouse;

