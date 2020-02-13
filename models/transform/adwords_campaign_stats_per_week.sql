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

  -- The start of the week this report is for
  date_trunc('week', MIN(report_date))::date as week_start,

  -- Generate a nice label: "[2019-12-09,2019-12-15] | Account | Campaign"
  CONCAT
  (
    '[',
      -- Get the start of the week
      date_trunc('week', MIN(report_date))::date, ',',
      -- Get the end of the week
      (date_trunc('week', MIN(report_date)) + '6 days')::date,
    '] | ',
    account_name , ' | ' , campaign_name
  ) as label,

  -- Aggregate Metrics for the report
  {{ tap_adwords.core_ad_metrics_aggregates() }}

from report

group by
  report_date_iso_year,
  report_date_week,
  account_id,
  account_name,
  campaign_id,
  campaign_name,
  currency

order by
  report_date_iso_year,
  report_date_week,
  account_name,
  campaign_name
