with report as (

     select *
     from {{ref('adwords_ad_report')}}

)

select

  -- The Account this report is for
  account_id,
  account_name,

  currency,

  -- The day (date) this report is for
  report_date,

  -- The Network and Device segments
  network,
  device,

  -- Generate a descriptive label: "2020-01-16 | Search Network | Computers | Account "
  CONCAT( report_date, ' | ', network, ' | ', device, ' | ', account_name ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics_aggregates() }}

from report

group by
  report_date,
  network,
  device,
  account_id,
  account_name,
  currency

order by
  report_date,
  network,
  device,
  account_name
