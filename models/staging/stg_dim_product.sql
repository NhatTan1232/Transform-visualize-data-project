WITH dim_product__source AS 
(
  SELECT DISTINCT
    product_id
    ,product_name
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`
)

,dim_product__cast_type AS 
(
  SELECT
    CAST(product_id AS INT64) AS product_key
    ,product_name
  FROM dim_product__source
  WHERE product_id IS NOT NULL
)

SELECT 
  product_key
  ,CASE
    WHEN product_name IS NULL THEN 'undefined'
    ELSE product_name
  END AS product_name
FROM dim_product__cast_type