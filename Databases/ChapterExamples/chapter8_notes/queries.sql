CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
region TEXT,
amount NUMERIC,
order_date DATE
);

-- Populate with sample data (skewed distribution is important for demos)
INSERT INTO orders (customer_id, region, amount, order_date)
SELECT
(random() * 1000)::INT,
CASE WHEN random() < 0.7 THEN 'North' ELSE 'South' END, -- skewed!
(random() * 1000)::NUMERIC,
'2020-01-01'::DATE + (random() * 1460)::INT
FROM generate_series(1, 500000);


-- Table profile view
SELECT
relname AS table_name,
reltuples::BIGINT AS est_rows,
relpages AS disk_blocks,
round((reltuples / NULLIF(relpages,0)::numeric, 0)
AS rows_per_block
FROM pg_class
WHERE relkind = 'r'
AND relname NOT LIKE 'pg_%'
ORDER BY reltuples DESC;

SELECT
  attname,
  histogram_bounds
FROM pg_stats
WHERE tablename = 'orders'
  AND attname = 'amount';
