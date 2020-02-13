{%- macro core_ad_metrics_aggregates() -%}

  SUM(impressions) as impressions,
  SUM(interactions) as interactions,

  -- Interaction Rate = interactions / impressions
  round((SUM(interactions) / NULLIF(SUM(impressions), 0)) * 100, 2) as interaction_rate,

  round(SUM(cost), 2) as cost,
  SUM(clicks) as clicks,

  -- CPC = cost / clicks
  round(SUM(cost) / NULLIF(SUM(clicks), 0), 2) as cpc,

  -- CPM = cost / impressions
  round((SUM(cost) / NULLIF(SUM(impressions), 0))  * 1000, 2) as cpm,

  -- CTR = clicks / impressions
  round((SUM(clicks) / NULLIF(SUM(impressions), 0))  * 100, 2) as ctr,

  SUM(conversions) as conversions,

  -- Cost per Convension = cost / conversions
  round(SUM(cost) / NULLIF(SUM(conversions), 0), 2) as cost_per_conversion,

  -- Convension Rate = conversions / interactions
  round((SUM(conversions) / SUM(interactions)) * 100, 2) as conversion_rate

{%- endmacro -%}
