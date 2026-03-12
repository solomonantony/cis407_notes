drop view v_sales_summary;
drop materialized view mv_sales_summary;
Drop table sales;

CREATE TABLE sales (
    sale_id     SERIAL PRIMARY KEY,
    sale_date   DATE           NOT NULL,
    region      TEXT           NOT NULL,
    category    TEXT           NOT NULL,
    amount      NUMERIC(10,2)  NOT NULL
);

INSERT INTO sales (sale_date, region, category, amount)
SELECT
    CURRENT_DATE - (random() * 1825)::INT,
    (ARRAY['North','South','East','West'])[1 + (random() * 3)::INT],
    (ARRAY['Electronics','Clothing','Food','Books','Toys'])[1 + (random() * 4)::INT],
    (random() * 990 + 10)::NUMERIC(10,2)
FROM generate_series(1, 5000000);

ANALYZE sales;

CREATE VIEW v_sales_summary AS
SELECT
    DATE_TRUNC('month', sale_date)  AS sale_month,
    region,
    category,
    COUNT(*)                        AS total_sales,
    SUM(amount)                     AS total_revenue,
    AVG(amount)                     AS avg_sale
FROM sales
GROUP BY 1, 2, 3;

CREATE MATERIALIZED VIEW mv_sales_summary AS
SELECT
    DATE_TRUNC('month', sale_date)  AS sale_month,
    region,
    category,
    COUNT(*)                        AS total_sales,
    SUM(amount)                     AS total_revenue,
    AVG(amount)                     AS avg_sale
FROM sales
GROUP BY 1, 2, 3
WITH DATA;




drop view v_sales_summary;
drop MATERIALIZED VIEW mv_sales_summary;
drop table sales;

\echo '--- Regular VIEW ---'
SELECT region, SUM(total_revenue) AS revenue
FROM   v_sales_summary
GROUP  BY region
ORDER  BY revenue DESC;


\echo '--- Materialized VIEW ---'
SELECT region, SUM(total_revenue) AS revenue
FROM   mv_sales_summary
GROUP  BY region
ORDER  BY revenue DESC;

SELECT sale_month, category, total_sales, total_revenue
FROM   v_sales_summary
WHERE  region = 'North'
ORDER  BY sale_month, category;

SELECT sale_month, category, total_sales, total_revenue
FROM   mv_sales_summary
WHERE  region = 'North'
ORDER  BY sale_month, category;
