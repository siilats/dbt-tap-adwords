{%- macro core_ad_metrics() -%}

  impressions as impressions,
  interactions as interactions,

  -- Interaction Rate = interactions / impressions
  round((1.0 * interactions / NULLIF(impressions, 0)) * 100, 2) as interaction_rate,

  round(cost, 2) as cost,
  clicks as clicks,

  -- CPC = cost / clicks
  round(cost / NULLIF(clicks, 0), 2) as cpc,

  -- CPM = cost / impressions
  round((cost / NULLIF(impressions, 0))  * 1000, 2) as cpm,

  -- CTR = clicks / impressions
  round((1.0 * clicks / NULLIF(impressions, 0))  * 100, 2) as ctr,

  conversions as conversions,

  -- Cost per Convension = cost / conversions
  round(cost / NULLIF(conversions, 0), 2) as cost_per_conversion,

  -- Convension Rate = conversions / interactions
  round((1.0 * conversions / NULLIF(interactions, 0)) * 100, 2) as conversion_rate

{%- endmacro -%}
