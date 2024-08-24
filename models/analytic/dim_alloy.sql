SELECT
  alloy_key
  ,value
  ,CASE
    WHEN value = 'Rotgold 585' THEN 'Rose Gold 585'
    WHEN value = 'Gelbgold 585' THEN 'Yellow Gold 585'
    WHEN value = 'Weißgold 750' THEN 'White Gold 750'
    WHEN value = 'Weißgold 585' THEN 'White Gold 585'
    WHEN value = 'Weißgold 375' THEN 'White Gold 375'
    WHEN value = 'Weiß-Gelbgold 375' THEN 'White Yellow Gold 375'
    WHEN value = 'Weiß-Rotgold 585' THEN 'White Rose Gold 585'
    WHEN value = 'Weiß-Gelbgold 585' THEN 'White Yellow Gold 585'
    WHEN value = 'Rotgold 375' THEN 'Rose Gold 375'
    WHEN value = 'Gelb-Weißgold 585' THEN 'Yellow White Gold 585'
    WHEN value = 'Gelbgold 375' THEN 'Yellow Gold 375'
    WHEN value = 'Rot-Weißgold 375' THEN 'Rose White Gold 375'
    WHEN value = 'Gelb-Weißgold 375' THEN 'Yellow White Gold 375'
    WHEN value = 'Gelb-Weißgold 750' THEN 'Yellow White Gold 750'
    WHEN value = 'Weiß-Rotgold 750' THEN 'White Rose Gold 750'
    WHEN value = 'Weiß-Gelbgold 750' THEN 'White Yellow Gold 750'
    WHEN value = 'Weiß-Gelb-Rotgold 585' THEN 'White Yellow Rose Gold 585'
    WHEN value = 'Weiß-Gelb-Rotgold 375' THEN 'White Yellow Rose Gold 375'
    WHEN value = 'Rot-Weißgold 750' THEN 'Rose White Gold 750'
    WHEN value = 'Rotgold 750' THEN 'Rose Gold 750'
    WHEN value = '950 Platin' THEN '950 Platinum'
    WHEN value = '925 Silber' THEN '925 Silver'
    WHEN value = 'Weiß-Rotgold 375' THEN 'White Rose Gold 375'
    WHEN value = '950 Palladium' THEN '950 Palladium'
    WHEN value = 'Gelbgold 750' THEN 'Yellow Gold 750'
    WHEN value = '585 Natural Yellow Gold' THEN 'Natural Yellow Gold 585'
    WHEN value = '585 Natural White Gold' THEN 'Natural White Gold 585'
    ELSE value
  END AS translated_value
FROM `de-gcp-project.glamira_stg.stg_dim_alloy`