ALTER TABLE silver.lakehouse.orders_cleaned ADD COLUMN comment VARCHAR;
SELECT * FROM silver.lakehouse.orders_cleaned LIMIT 5;     

SELECT snapshot_id, committed_at, operation FROM silver.lakehouse."orders_cleaned$snapshots" ORDER BY committed_at;
SELECT COUNT(*) FROM silver.lakehouse.orders_cleaned FOR VERSION AS OF 0000000000000000000;  
