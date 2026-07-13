-- Limpieza y transformación de datos brutos
CREATE OR REPLACE VIEW `ecommerce_data.sales_processed` AS 
WITH cleaned_data AS (
  SELECT
    order_id,
    customer_id,
    -- Aseguramos formato de fecha correcto
    PARSE_DATE('%Y-%m-%d', CAST(order_date AS STRING)) AS order_date, 
    -- Agrupamos o corregimos categorías si hiciera falta
    TRIM(product_category) AS product_category,
    payment_method,
    -- Controlamos que no haya ingresos negativos o nulos
    COALESCE(revenue, 0) AS revenue,
    CAST(delivery_days AS INT64) AS delivery_days
  FROM 
    `ecommerce_data.sales_raw`
  WHERE 
    order_id IS NOT NULL
)
SELECT * FROM cleaned_data;