CREATE TABLE gold.lakehouse.q18_result AS
SELECT
  c.name,
  c.custkey,
  o.orderkey,
  o.orderdate,
  o.totalprice,
  SUM(l.quantity) AS total_quantity
FROM silver.lakehouse.customer_cleaned AS c
JOIN silver.lakehouse.orders_cleaned AS o ON c.custkey = o.custkey
JOIN tpch.sf1.lineitem AS l ON o.orderkey = l.orderkey
WHERE o.orderkey IN (
  SELECT orderkey
  FROM tpch.sf1.lineitem
  GROUP BY orderkey
  HAVING SUM(quantity) > 300
)
GROUP BY c.name, c.custkey, o.orderkey, o.orderdate, o.totalprice
ORDER BY o.totalprice DESC, o.orderdate
LIMIT 100;

SELECT * FROM gold.lakehouse.q18_result;

ALTER TABLE silver.lakehouse.orders_cleaned ADD COLUMN comment VARCHAR;