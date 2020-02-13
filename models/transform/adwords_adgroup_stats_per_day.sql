with report as (

     select *
     from {{ref('adwords_ad_report')}}

)

select

  -- The Account, Campaign, Ad Group this report is for
  account_id,
  account_name,

  campaign_id,
  campaign_name,

  ad_group_id,
  ad_group_name,

  currency,

  -- The day (date) this report is for
  report_date,

  -- Generate a nice label: "2020-01-16 | Account | Campaign | Ad Group | Ad Type (Enabled) | USD"
  CONCAT
  (
    report_date, ' | ',
    account_name, ' | ', campaign_name, ' | ', ad_group_name
  ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics() }}

from report

where impressions is not NULL

order by
  report_date,
  account_name,
  campaign_name,
  ad_group_name
