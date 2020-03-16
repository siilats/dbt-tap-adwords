with report as (

     select *
     from {{ref('adwords_ad_report')}}

)

select

  -- The Account, Campaign and Ad Group this report is for
  account_id,
  account_name,

  campaign_id,
  campaign_name,

  ad_group_id,
  ad_group_name,

  currency,

  -- The day (date) this report is for
  report_date,

  -- Generate a descriptive label: "2020-01-16 | Account | Campaign | Ad Group"
  CONCAT
  (
    report_date, ' | ',
    account_name, ' | ', campaign_name, ' | ', ad_group_name
  ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics_aggregates() }}

from report

group by
  report_date,
  account_id,
  account_name,
  campaign_id,
  campaign_name,
  ad_group_id,
  ad_group_name,
  currency

order by
  report_date,
  account_name,
  campaign_name,
  ad_group_name
