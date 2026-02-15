CREATE OR REPLACE TABLE products_clean AS
WITH raw AS (
    SELECT *
    FROM read_json_auto(
        'C:/Users/tanya/DataGripProjects/HW1_products/flipkart_fashion_products_dataset.json')),
details_flat AS (
    SELECT
        r.*,
        UNNEST(r.product_details) AS detail
    FROM raw r
)

SELECT
    CAST(_id AS VARCHAR) AS product_id,
    NULLIF(brand, '') AS brand,
    NULLIF(category, '') AS category,
    NULLIF(sub_category, '') AS sub_category,
    NULLIF(title, '') AS title,
    NULLIF(seller, '') AS seller,
    CAST(NULLIF(REPLACE(actual_price, ',', ''), '') AS DOUBLE) AS actual_price,
    CAST(NULLIF(REPLACE(selling_price, ',', ''), '') AS DOUBLE) AS selling_price,
    CAST(NULLIF(average_rating, '') AS DOUBLE) AS average_rating,
    CAST(NULLIF(REPLACE(discount, '% off', ''), '') AS DOUBLE) AS discount_percent,
    STRPTIME(NULLIF(crawled_at, ''), '%m/%d/%Y, %H:%M:%S') AS crawled_at,
    out_of_stock,
    NULLIF(description, '') AS description,
    NULLIF(url, '') AS url,
    NULLIF(pid, '') AS pid,
    map_keys(detail)[1] AS attribute,
    map_values(detail)[1] AS value
FROM details_flat;
SELECT * FROM products_clean LIMIT 60;

SELECT COUNT(DISTINCT product_id) AS total_products
FROM products_clean;

--1 Скільки товару немає в наявності?
SELECT
    out_of_stock,
    COUNT(DISTINCT product_id) AS n_products,
    ROUND(100.0 * COUNT(DISTINCT product_id)/ SUM(COUNT(DISTINCT product_id)) OVER (),2) AS percent_share
FROM products_clean
GROUP BY out_of_stock;
-- We observe that out of approximately 30,000 products, only 1,742 are out of stock, which represents just 5.81%.
-- This indicates a high level of product availability on the platform and suggests effective inventory management.

-- 2. Топ-3 найдорожчі бренди в кожній категорії
WITH ranked AS (
    SELECT
        category,
        brand,
        ROUND(AVG(selling_price), 2) AS avg_price,
        RANK() OVER (
            PARTITION BY category
            ORDER BY AVG(selling_price) DESC
        ) AS rank_in_category
    FROM products_clean
    WHERE brand IS NOT NULL
    GROUP BY category, brand
)
SELECT *
FROM ranked
WHERE rank_in_category <= 3
ORDER BY category, rank_in_category;

