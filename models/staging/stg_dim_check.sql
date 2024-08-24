WITH dim_checkout__source AS (
  SELECT
    src.id
    ,src.email_address
    ,src.local_time
    ,src.city_name
    ,src.country_name
    ,src.region_name
    ,cart.product_id
    ,option.option_label
    ,option.value_label
    ,cart.amount
    ,cart.price
    ,cart.currency
    ,src.order_id
    ,CASE
      WHEN FARM_FINGERPRINT(CONCAT(src.city_name, src.region_name, src.country_name)) IN (
        SELECT location_key
        FROM `de-gcp-project.glamira_stg.stg_dim_location`
      )
      THEN FARM_FINGERPRINT(CONCAT(src.city_name, src.region_name, src.country_name))
      ELSE 0
    END AS location_key
  FROM 
    `de-gcp-project.glamira_raw.glamira_raw_2` src
    ,UNNEST(src.`cart_products`) AS cart
    ,UNNEST(cart.`option`) AS option
  WHERE src.collection = 'checkout_success' AND email_address != 'hatice.erciyes@glamira-group.com'
)

,dim_checkout__add_locationkey AS 
(
  SELECT
    id,
    email_address,
    local_time,
    order_id,
    CASE
      WHEN FARM_FINGERPRINT(CONCAT(city_name, region_name, country_name)) IN (
        SELECT location_key
        FROM `de-gcp-project.glamira_stg.stg_dim_location`
      ) THEN FARM_FINGERPRINT(CONCAT(city_name, region_name, country_name))
      ELSE 0
    END AS location_key
    ,product_id
    ,option_label
    ,value_label
    ,amount
    ,price
    ,currency
  FROM dim_checkout__source
)

,dim_checkout_labels AS (
  SELECT
    id,
    email_address,
    local_time,
    order_id,
    location_key,
    product_id,
    MAX(CASE WHEN option_label = 'alloy' THEN value_label END) AS alloy,
    MAX(CASE WHEN option_label = 'diamond' THEN value_label END) AS diamond,
    MAX(amount) AS amount,
    MAX(price) AS price,
    currency
  FROM dim_checkout__add_locationkey
  GROUP BY id, email_address, local_time, order_id, location_key, product_id, currency
),

dim_check__add_undefined AS (
  SELECT
    id,
    CASE
      WHEN email_address = '' THEN 'undefined'
      ELSE email_address
    END AS email_address,
    local_time,
    product_id AS product_key,
    location_key,
    order_id AS order_key,
    CASE
      WHEN alloy IS NULL THEN 0
      ELSE FARM_FINGERPRINT(alloy)
    END AS alloy_key,
    CASE
      WHEN diamond IS NULL THEN 0
      ELSE FARM_FINGERPRINT(diamond)
    END AS diamond_key,
    amount,
    price,
    CASE
      WHEN currency = '' THEN 'undefined'
      ELSE currency
    END AS currency
  FROM dim_checkout_labels
),
dim_check__transform_time_price AS (
  SELECT
    id,
    email_address,
    SUBSTR(local_time, 1, STRPOS(local_time, ' ') - 1) AS local_time,
    product_key,
    location_key,
    order_key,
    alloy_key,
    diamond_key,
    amount,
    CASE
      WHEN SUBSTR(REGEXP_REPLACE(price, r'[^0-9]', ''), -2, 2) = '00' 
      THEN SUBSTR(REGEXP_REPLACE(price, r'[^0-9]', ''), 1, LENGTH(REGEXP_REPLACE(price, r'[^0-9]', '')) - 2)
      ELSE REGEXP_REPLACE(price, r'[^0-9]', '')
    END AS price,
    currency
  FROM dim_check__add_undefined
),
dim_check__checkoutkey AS (
  SELECT
    FARM_FINGERPRINT(CONCAT(id, product_key, order_key)) AS checkout_key,
    email_address,
    local_time,
    product_key,
    location_key,
    order_key,
    alloy_key,
    diamond_key,
    amount,
    price,
    currency
  FROM dim_check__transform_time_price
)
SELECT
  checkout_key,
  email_address,
  CAST(local_time AS DATE) AS local_time,
  product_key,
  location_key,
  CAST(order_key AS INT64) AS order_key,
  alloy_key,
  diamond_key,
  amount,
  CAST(price AS FLOAT64) AS price,
  dim_check__checkoutkey.currency
FROM dim_check__checkoutkey
