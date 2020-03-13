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

  -- The start of the month this report is for
  to_char(MIN(report_date), 'YYYY-MM') as month,
  date_trunc('month', MIN(report_date))::date as month_start,

  -- Generate a descriptive label: "2020-02 | Account | Campaign | Ad Group | Ad Type (Enabled)"
  CONCAT
  (
    to_char(MIN(report_date), 'YYYY-MM'), ' | ',
    account_name , ' | ' , campaign_name , ' | ' , ad_group_name , ' | ' ,
    ad_type , '(' , ad_id , ')'
  ) as label,

  -- Aggregate Metrics for the report
  {{ tap_adwords.core_ad_metrics_aggregates() }}

from report

group by
  report_date_year,
  report_date_month,
  account_id,
  account_name,
  campaign_id,
  campaign_name,
  ad_group_id,
  ad_group_name,
  ad_id,
  ad_type,
  ad_status,
  currency

order by
  report_date_year,
  report_date_month,
  account_name,
  campaign_name,
  ad_group_name,
  ad_type,
  ad_id,
  ad_status
