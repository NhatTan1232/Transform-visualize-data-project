WITH  dim_color__source AS 
(  
  SELECT 
    option.option_id
    ,option.option_label
    ,option.value_id
    ,option.value_label
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`
  ,UNNEST(`de-gcp-project.glamira_raw.glamira_raw_2`.`option`) AS option
  WHERE  option.option_label ='alloy'
)

,dim_color__get_short_text AS
( 
  SELECT DISTINCT
    value_label,
    SUBSTR(value_label, 0, STRPOS(value_label, '-')) AS color_short_text
  FROM dim_color__source
)

SELECT DISTINCT
  FARM_FINGERPRINT(color_short_text) AS color_key,
  REPLACE(color_short_text, '-', '') AS color_short_text,
  CASE 
    WHEN color_short_text= 'white_yellow-' THEN 'White Yellow'
    WHEN color_short_text= 'red-' THEN 'Rose'
    WHEN color_short_text= 'yellow-' THEN 'Yellow'
    WHEN color_short_text= 'white-' THEN 'White'
    WHEN color_short_text= 'red_white-' THEN 'Rose White'        
    WHEN color_short_text= 'yellow_white-' THEN 'Yellow White'
    WHEN color_short_text= 'white_red-' THEN 'White Rose'
    WHEN color_short_text= 'yellow_white_red-' THEN 'Yellow White Rose'
    WHEN color_short_text= 'white_yellow_red-' THEN 'White Yellow Rose'
    WHEN color_short_text= 'red_white_yellow-' THEN 'Rose White Yellow'
    WHEN color_short_text= 'black_yellow-' THEN 'Black Yellow'
    WHEN color_short_text= 'black_white-' THEN 'Black White'
    WHEN color_short_text= 'black_red-' THEN 'Black Rose'
    WHEN color_short_text= 'natural_red-' THEN 'Rose'
    WHEN color_short_text= 'natural_white-' THEN 'White'
    WHEN color_short_text= 'natural_yellow-' THEN 'Yellow'
    ELSE 'Undefined'
END as color_name
FROM dim_color__get_short_text
WHERE color_short_text != ''