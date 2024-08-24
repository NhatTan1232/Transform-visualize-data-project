WITH dim_diamond__source AS
(
  SELECT distinct option.value_label
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`,
  UNNEST (`de-gcp-project.glamira_raw.glamira_raw_2`.`cart_products`) as cart,
  UNNEST(cart.`option`) as option
  WHERE option.option_label = 'diamond'
)

, dim_diamond__add_key AS 
(
  SELECT 
    FARM_FINGERPRINT(dim_diamond__source.value_label) AS diamond_key
    ,value_label
  FROM dim_diamond__source
)

SELECT 
  0 AS diamond_key
  ,'undefined' as value
UNION ALL
SELECT *
FROM dim_diamond__add_key
WHERE value_label != ''