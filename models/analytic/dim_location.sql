WITH dim_location__cast_type AS
(
  SELECT
    CAST(location_key AS INT64) AS location_key
    ,CAST(city_name AS STRING) AS city_name
    ,CAST(country_name AS STRING) AS country_name
    ,CAST(country_code AS STRING) AS country_code
    ,CAST(region_name AS STRING) AS region_name
  FROM `de-gcp-project.glamira_stg.stg_dim_location`
)

,dim_location__add_null AS
(
  SELECT
    0 AS location_key
    ,'undefined' AS city_name
    ,'undefined' AS country_name
    ,'undefined' AS country_code
    ,'undefined' AS region_name
  UNION ALL
  SELECT *
  FROM dim_location__cast_type
)

SELECT *
FROM dim_location__add_null