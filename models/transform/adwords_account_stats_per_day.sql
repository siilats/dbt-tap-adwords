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

  -- Generate a descriptive label: "2020-01-16 | Account "
  CONCAT( report_date, ' | ', account_name ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics_aggregates() }}

from report

group by
  report_date,
  account_id,
  account_name,
  currency

order by
  report_date,
  account_name
