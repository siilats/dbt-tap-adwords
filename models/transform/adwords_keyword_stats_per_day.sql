with report as (

     select *
     from {{ref('adwords_keywords_report')}}

)

select

  -- The Account, Campaign, Ad Group, Ad this report is for
  account_id,
  account_name,

  campaign_id,
  campaign_name,

  ad_group_id,
  ad_group_name,

  keyword_id,
  keyword,
  keyword_status,

  top_of_page_cpc,
  first_page_cpc,

  currency,

  -- The day (date) this report is for
  report_date,

  -- Generate a nice label: "2020-01-16 | Account | Campaign | Ad Group | Ad Type (Enabled)"
  CONCAT
  (
    report_date, ' | ',
    account_name, ' | ', campaign_name, ' | ', ad_group_name, ' | ',
    keyword, '(', keyword_status, ')'
  ) as label,

  -- Metrics for the report
  {{ tap_adwords.core_ad_metrics() }}

from report

-- Keyword Reports return one row per day even for keywords without any impressions
-- Skip the noise from the long tail for campaigns with too many keywords defined
where impressions is not NULL

order by
  report_date,
  account_name,
  campaign_name,
  ad_group_name,
  keyword,
  keyword_status
