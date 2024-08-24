WITH dim_currency__source AS (
  SELECT DISTINCT currency 
  FROM `de-gcp-project.glamira_stg.stg_dim_check`
)

,dim_currency__get_code AS 
(
  SELECT
    currency
    ,CASE 
      WHEN currency = 'CAD $' THEN 'CAD'
      WHEN currency = 'лв.' THEN 'BGN'
      WHEN currency = 'د.ك.‏' THEN 'KWD'
      WHEN currency = 'kr' THEN 'NOK' 
      WHEN currency = '£' THEN 'GBP'
      WHEN currency = 'CHF' THEN 'CHF'
      WHEN currency = ' din.' THEN 'RSD'
      WHEN currency = 'USD $' THEN 'USD'
      WHEN currency = 'CLP' THEN 'CLP'
      WHEN currency = '₱' THEN 'PHP'
      WHEN currency = 'DOP $' THEN 'DOP'
      WHEN currency = 'R$' THEN 'BRL'
      WHEN currency = 'AU $' THEN 'AUD'
      WHEN currency = 'Kč' THEN 'CZK'
      WHEN currency = 'Ft' THEN 'HUF'
      WHEN currency = 'MXN $' THEN 'MXN'
      WHEN currency = 'COP $' THEN 'COP'
      WHEN currency = '₹' THEN 'INR'
      WHEN currency = '₺' THEN 'TRY'
      WHEN currency = '₫' THEN 'VND'
      WHEN currency = '￥' THEN 'JPY'
      WHEN currency = '₲' THEN 'PYG'
      WHEN currency = '€' THEN 'EUR'
      WHEN currency = 'NZD $' THEN 'NZD'
      WHEN currency = 'UYU' THEN 'UYU'
      WHEN currency = 'Lei' THEN 'RON'
      WHEN currency = 'zł' THEN 'PLN'
      WHEN currency = '$' THEN 'USD' 
      WHEN currency = 'kn' THEN 'HRK'
      WHEN currency = 'SGD $' THEN 'SGD'
      WHEN currency = 'HKD $' THEN 'HKD'
      WHEN currency = 'GTQ Q' THEN 'GTQ'
      WHEN currency = 'PEN S/.' THEN 'PEN'
      WHEN currency = 'CRC ₡' THEN 'CRC'
      WHEN currency = 'BOB Bs' THEN 'BOB'
      ELSE 'undefined'
    END AS currency_code
  FROM dim_currency__source
)

,dim_currency__get_exchange AS 
(
  SELECT
    currency
    ,currency_code
    ,CASE
      WHEN currency_code = 'CAD' THEN 0.75
      WHEN currency_code = 'BGN' THEN 0.55
      WHEN currency_code = 'KWD' THEN 3.26
      WHEN currency_code = 'NOK' THEN 0.10 
      WHEN currency_code = 'GBP' THEN 1.30
      WHEN currency_code = 'CHF' THEN 1.10
      WHEN currency_code = 'RSD' THEN 0.009 
      WHEN currency_code = 'JOD' THEN 1.41 
      WHEN currency_code = 'USD' THEN 1.00  
      WHEN currency_code = 'CLP' THEN 0.0012
      WHEN currency_code = 'PHP' THEN 0.017
      WHEN currency_code = 'DOP' THEN 0.018
      WHEN currency_code = 'BRL' THEN 0.20
      WHEN currency_code = 'AUD' THEN 0.65
      WHEN currency_code = 'CZK' THEN 0.043
      WHEN currency_code = 'HUF' THEN 0.0028
      WHEN currency_code = 'MXN' THEN 0.056
      WHEN currency_code = 'COP' THEN 0.00026
      WHEN currency_code = 'INR' THEN 0.012
      WHEN currency_code = 'TRY' THEN 0.036
      WHEN currency_code = 'VND' THEN 0.000041
      WHEN currency_code = 'JPY' THEN 0.007 
      WHEN currency_code = 'CNY' THEN 0.14  
      WHEN currency_code = 'PYG' THEN 0.00014
      WHEN currency_code = 'EUR' THEN 1.10
      WHEN currency_code = 'NZD' THEN 0.60
      WHEN currency_code = 'UYU' THEN 0.025
      WHEN currency_code = 'RON' THEN 0.22
      WHEN currency_code = 'PLN' THEN 0.24
      WHEN currency_code = 'HRK' THEN 0.15 
      WHEN currency_code = 'SGD' THEN 0.73
      WHEN currency_code = 'HKD' THEN 0.13
      WHEN currency_code = 'GTQ' THEN 0.13
      WHEN currency_code = 'PEN' THEN 0.26
      WHEN currency_code = 'CRC' THEN 0.0019
      WHEN currency_code = 'BOB' THEN 0.14
      ELSE 1
    END AS exchange_rate_to_usd
  FROM dim_currency__get_code
)

SELECT
  currency
  ,currency_code
  ,CASE
    WHEN currency_code = 'CAD' THEN 'Canadian Dollar'
    WHEN currency_code = 'BGN' THEN 'Bulgarian Lev'
    WHEN currency_code = 'KWD' THEN 'Kuwaiti Dinar'
    WHEN currency_code = 'NOK' THEN 'Norwegian Krone'
    WHEN currency_code = 'GBP' THEN 'British Pound'
    WHEN currency_code = 'CHF' THEN 'Swiss Franc'
    WHEN currency_code = 'RSD' THEN 'Serbian Dinar'
    WHEN currency_code = 'JOD' THEN 'Jordanian Dinar'
    WHEN currency_code = 'USD' THEN 'United States Dollar'
    WHEN currency_code = 'CLP' THEN 'Chilean Peso'
    WHEN currency_code = 'PHP' THEN 'Philippine Peso'
    WHEN currency_code = 'DOP' THEN 'Dominican Peso'
    WHEN currency_code = 'BRL' THEN 'Brazilian Real'
    WHEN currency_code = 'AUD' THEN 'Australian Dollar'
    WHEN currency_code = 'CZK' THEN 'Czech Koruna'
    WHEN currency_code = 'HUF' THEN 'Hungarian Forint'
    WHEN currency_code = 'MXN' THEN 'Mexican Peso'
    WHEN currency_code = 'COP' THEN 'Colombian Peso'
    WHEN currency_code = 'INR' THEN 'Indian Rupee'
    WHEN currency_code = 'TRY' THEN 'Turkish Lira'
    WHEN currency_code = 'VND' THEN 'Vietnamese Dong'
    WHEN currency_code = 'JPY' THEN 'Japanese Yen'
    WHEN currency_code = 'CNY' THEN 'Chinese Yuan'
    WHEN currency_code = 'PYG' THEN 'Paraguayan Guarani'
    WHEN currency_code = 'EUR' THEN 'Euro'
    WHEN currency_code = 'NZD' THEN 'New Zealand Dollar'
    WHEN currency_code = 'UYU' THEN 'Uruguayan Peso'
    WHEN currency_code = 'RON' THEN 'Romanian Leu'
    WHEN currency_code = 'PLN' THEN 'Polish Złoty'
    WHEN currency_code = 'HRK' THEN 'Croatian Kuna'
    WHEN currency_code = 'SGD' THEN 'Singapore Dollar'
    WHEN currency_code = 'HKD' THEN 'Hong Kong Dollar'
    WHEN currency_code = 'GTQ' THEN 'Guatemalan Quetzal'
    WHEN currency_code = 'PEN' THEN 'Peruvian Sol'
    WHEN currency_code = 'CRC' THEN 'Costa Rican Colón'
    WHEN currency_code = 'BOB' THEN 'Bolivian Boliviano'
    ELSE 'undefined'
  END AS currency_name
  ,exchange_rate_to_usd
FROM dim_currency__get_exchange

