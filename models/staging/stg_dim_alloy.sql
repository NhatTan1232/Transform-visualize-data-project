WITH dim_alloy__source AS
(
  SELECT distinct option.value_label
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`,
  UNNEST (`de-gcp-project.glamira_raw.glamira_raw_2`.`cart_products`) as cart,
  UNNEST(cart.`option`) as option
  WHERE option.option_label = 'alloy'
)

, dim_alloy__add_key AS 
(
  SELECT 
    FARM_FINGERPRINT(dim_alloy__source.value_label) AS alloy_key
    ,value_label
  FROM dim_alloy__source
)

SELECT 
  0 AS alloy_key
  ,'undefined' as value
UNION ALL
SELECT *
FROM dim_alloy__add_key
WHERE value_label != ''