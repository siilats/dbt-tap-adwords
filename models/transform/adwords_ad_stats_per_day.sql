with report as (

     select *
     from {{ref('adwords_ad_report')}}

)

select

  -- The Account, Campaign, Ad Group, Ad this report is for
  account_id,
  account_name,

  campaign_id,
  campaign_name,

  ad_group_id,
  ad_group_name,

  ad_id,
  ad_type,
  ad_status,

  currency,

  -- The day (date) this report is for
  report_date,

  -- Generate a nice label: "2020-01-16 | Account | Campaign | Ad Group | Ad Type (Enabled)"
  CONCAT
  (
    report_date, ' | ',
    account_name, ' | ', campaign_name, ' | ', ad_group_name, ' | ',
    ad_type, '(', ad_status, ')'
  ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics() }}

from report

order by
  report_date,
  account_name,
  campaign_name,
  ad_group_name,
  ad_type,
  ad_status
