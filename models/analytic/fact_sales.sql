WITH dim_sales__source AS 
(
  SELECT
    checkout_key
    ,email_address
    ,local_time
    ,product_key
    ,location_key
    ,order_key
    ,alloy_key
    ,diamond_key
    ,amount
    ,price
    ,stg_dim_currency.exchange_rate_to_usd
  FROM 
    `de-gcp-project.glamira_stg.stg_dim_check` AS stg_dim_check
    ,`de-gcp-project.glamira_stg.stg_dim_currency` AS stg_dim_currency
  WHERE stg_dim_check.currency = stg_dim_currency.currency
)

SELECT
  checkout_key
  ,email_address
  ,local_time
  ,product_key
  ,location_key
  ,order_key
  ,alloy_key
  ,diamond_key
  ,amount
  ,price
  ,ROUND((price * exchange_rate_to_usd), 2) AS unit_price_in_usd
  ,ROUND((amount * price * exchange_rate_to_usd), 2) AS total_price_in_usd
FROM dim_sales__source