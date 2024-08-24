with dim_quality__source as (
  SELECT a.quality, a.quality_label
  FROM `de-gcp-project.glamira_raw.glamira_raw_2`,
  UNNEST (`de-gcp-project.glamira_raw.glamira_raw_2`.`option`) as a 
  GROUP BY a.quality, a.quality_label
)

, dim_quality__add_undefine as (
  SELECT 
    'undefined' as quality,
    'undefined' as quality_label
  FROM dim_quality__source
  WHERE quality_label IS NULL
  UNION ALL
  SELECT *
  FROM dim_quality__source
  WHERE quality_label IS NOT NULL
)

SELECT quality_label, quality
FROM dim_quality__add_undefine
GROUP BY quality, quality_label