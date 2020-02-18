with report as (

     select *
     from {{ref('adwords_ad_report')}}

)

select

  -- The Account this report is for
  account_id,
  account_name,

  currency,

  -- The start of the month this report is for
  to_char(MIN(report_date), 'YYYY-MM') as month,
  date_trunc('month', MIN(report_date))::date as month_start,

  -- Generate a descriptive label: "2020-02 | Account "
  CONCAT
  (
    to_char(MIN(report_date), 'YYYY-MM'), ' | ', account_name
  ) as label,

  -- Aggregate Metrics for the report
  {{ tap_adwords.core_ad_metrics_aggregates() }}

from report

group by
  report_date_year,
  report_date_month,
  account_id,
  account_name,
  currency

order by
  report_date_year,
  report_date_month,
  account_name
