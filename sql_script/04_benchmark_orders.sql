DROP TABLE IF EXISTS silver.lakehouse.orders_zstd;
DROP TABLE IF EXISTS silver.lakehouse.orders_gzip;
SET SESSION silver.compression_codec = 'ZSTD';
CREATE TABLE silver.lakehouse.orders_zstd WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.orders;
SET SESSION silver.compression_codec = 'GZIP';
CREATE TABLE silver.lakehouse.orders_gzip WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.orders;

SELECT 'zstd' AS t, SUM(file_size_in_bytes)/1000000.0 AS mb FROM silver.lakehouse."orders_zstd$files"
UNION ALL
SELECT 'gzip', SUM(file_size_in_bytes)/1000000.0 FROM silver.lakehouse."orders_gzip$files";

SELECT orderpriority, COUNT(*) AS cnt, SUM(totalprice) AS revenue FROM silver.lakehouse.orders_zstd GROUP BY orderpriority;
SELECT orderpriority, COUNT(*) AS cnt, SUM(totalprice) AS revenue FROM silver.lakehouse.orders_gzip GROUP BY orderpriority;
