with report as (

     select *
     from {{ref('adwords_ad_report')}}

)

select

  -- The Account and Campaign this report is for
  account_id,
  account_name,

  campaign_id,
  campaign_name,

  currency,

  -- The day (date) this report is for
  report_date,

  -- Generate a nice label: "2020-01-16 | Account | Campaign"
  CONCAT
  (
    report_date, ' | ', account_name, ' | ', campaign_name
  ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics() }}

from report

where impressions is not NULL

order by
  report_date,
  account_name,
  campaign_name
