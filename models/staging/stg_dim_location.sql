WITH dim_location__source AS (
  SELECT 
    city_name
    ,country_name 
    ,country_code
    ,region_name 
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`
  GROUP BY 
    city_name 
    ,country_name 
    ,country_code
    ,region_name
)

,dim_location__remove_unknown AS (
  SELECT *
  FROM dim_location__source
  WHERE dim_location__source.city_name != '-'
)

, dim_location__add_key AS (
  SELECT
    FARM_FINGERPRINT(CONCAT(city_name, region_name, country_name)) AS location_key
    ,city_name
    ,country_name
    ,country_code
    ,region_name
  FROM dim_location__remove_unknown
)

SELECT
  0 AS location_key
  ,'undefined' AS city_name
  ,'undefined' AS country_name
  ,'undefined' AS country_code
  ,'undefined' AS region_name
FROM dim_location__add_key
WHERE dim_location__add_key.city_name IS NULL
UNION ALL
SELECT *
FROM dim_location__add_key
WHERE dim_location__add_key.city_name IS NOT NULL
