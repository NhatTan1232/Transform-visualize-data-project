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

,dim_location__add_continent AS
(
  SELECT
    location_key
    ,city_name
    ,country_name
    ,country_code
    ,region_name
    ,CASE
      WHEN country_name IN ('Afghanistan', 'Armenia', 'Azerbaijan', 'Bahrain', 'Bangladesh', 'China', 'Georgia', 'Hong Kong', 'India', 'Indonesia', 'Iran (Islamic Republic of)', 'Iraq', 'Israel', 'Japan', 'Jordan', 'Kazakhstan', 'Korea (the Republic of)', 'Kuwait', 'Lebanon', 'Malaysia', 'Myanmar', 'Nepal', 'Oman', 'Pakistan', 'Palestine, State of', 'Philippines', 'Qatar', 'Saudi Arabia', 'Singapore', 'Sri Lanka', 'Syrian Arab Republic', 'Taiwan (Province of China)', 'Thailand', 'United Arab Emirates', 'Viet Nam') THEN 'Asia'
      WHEN country_name IN ('Aland Islands', 'Albania', 'Andorra', 'Austria', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark', 'Estonia', 'Faroe Islands', 'Finland', 'France', 'Germany', 'Gibraltar', 'Greece', 'Greenland', 'Guernsey', 'Hungary', 'Iceland', 'Ireland', 'Isle of Man', 'Italy', 'Jersey', 'Latvia', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Malta', 'Monaco', 'Montenegro', 'Netherlands (Kingdom of the)', 'North Macedonia', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russian Federation', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Ukraine', 'United Kingdom of Great Britain and Northern Ireland') THEN 'Europe'
      WHEN country_name IN ('Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Cabo Verde', 'Cameroon', 'Congo', 'Congo (the Democratic Republic of the)', "Cote D'ivoire", 'Egypt', 'Gabon', 'Ghana', 'Kenya', 'Madagascar', 'Malawi', 'Mali', 'Mauritius', 'Mayotte', 'Morocco', 'Mozambique', 'Nigeria', 'Reunion', 'Rwanda', 'Sao Tome and Principe', 'Senegal', 'Somalia', 'South Africa', 'Tanzania, the United Republic of', 'Togo', 'Tunisia', 'Uganda', 'Zambia', 'Zimbabwe') THEN 'Africa'
      WHEN country_name IN ('Antigua and Barbuda', 'Argentina', 'Aruba', 'Bahamas (the)', 'Barbados', 'Belize', 'Bolivia (Plurinational State of)', 'Brazil', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Cuba', 'Dominica', 'Dominican Republic', 'Ecuador', 'El Salvador', 'Grenada', 'Guadeloupe', 'Guatemala', 'Honduras', 'Jamaica', 'Mexico', 'Nicaragua', 'Panama', 'Paraguay', 'Peru', 'Puerto Rico', 'Saint Lucia', 'Trinidad and Tobago', 'United States of America', 'Uruguay', 'Venezuela (Bolivarian Republic of)', 'Virgin Islands (U.S.)') THEN 'North America'
      WHEN country_name IN ('Australia', 'Fiji', 'French Polynesia', 'New Caledonia', 'New Zealand', 'Samoa') THEN 'Oceania'
      ELSE 'undefined'
    END AS continent_name 
  FROM dim_location__cast_type
)

,dim_location__add_null AS
(
  SELECT
    0 AS location_key
    ,'undefined' AS city_name
    ,'undefined' AS country_name
    ,'undefined' AS country_code
    ,'undefined' AS region_name
    ,'undefined' AS continent_name
  UNION ALL
  SELECT *
  FROM dim_location__add_continent
)

SELECT *
FROM dim_location__add_null