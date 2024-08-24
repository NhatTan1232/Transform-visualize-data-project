WITH dim_metal__source AS (
  SELECT 
    option.option_id
    ,option.option_label
    ,option.value_id
    ,option.value_label
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`
  ,UNNEST(`de-gcp-project.glamira_raw.glamira_raw_2`.`option`) AS option
  WHERE  option.option_label ='alloy'
)

,dim_metal__get_short_text AS (
SELECT DISTINCT
  value_label,
  REGEXP_EXTRACT(value_label, r'-([^&]*)') AS metal_short_text,
  SUBSTR(value_label, STRPOS(value_label, '-') + 1) AS extracted_text
FROM dim_metal__source
)

,dim_metal__metal_name AS 
(
  SELECT 
    DISTINCT
    FARM_FINGERPRINT(metal_short_text) AS metal_key,
    dim_metal__get_short_text.extracted_text
    metal_short_text,
    CASE 
        WHEN metal_short_text= '375' THEN '9K Gold - 375'
        WHEN metal_short_text= '417' THEN '10K Gold - 417'
        WHEN metal_short_text= '585' THEN '14K Gold - 585'
        WHEN metal_short_text= '750' THEN '18K Gold - 750'
        WHEN metal_short_text= 'platin' THEN '950 Platinum'        
        WHEN metal_short_text= 'platin_375' THEN '375 Platinum'
        WHEN metal_short_text= 'platin_417' THEN '417 Platinum'
        WHEN metal_short_text= 'platin_585' THEN '585 Platinum'
        WHEN metal_short_text= 'platin_750' THEN '750 Platinum'
        WHEN metal_short_text= 'palladium' THEN '950 Palladium'
        WHEN metal_short_text= 'silber' THEN '925 Silver'
        WHEN metal_short_text= 'silber_375' THEN '375 Silver'
        WHEN metal_short_text= 'silber_417' THEN '417 Silver'
        WHEN metal_short_text= 'ceramic585' THEN 'Ceramic / 585 Gold'
        WHEN metal_short_text= 'edelstahl585' THEN 'Edelstahl / 585 Gold'
        WHEN metal_short_text= 'stainless' THEN 'Stainless Steel'
        ELSE 'Undefined'
    END AS metal_name
  FROM dim_metal__get_short_text
  WHERE metal_short_text IS NOT NULL
)

SELECT *
FROM dim_metal__metal_name