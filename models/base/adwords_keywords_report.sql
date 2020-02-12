with source as (

    select * from {{var('schema')}}.keywords_performance_report

),

renamed as (

    select

        -- Dimensions common in all Performance Reports
        {{ tap_adwords.performance_report_dimensions() }},

        -- Report Segments
        day::date                            as report_date,
        keyword                              as keyword,

        -- Metrics common in all Performance Reports
        {{ tap_adwords.performance_report_metrics() }},

        -- Metrics available only in the Keywords Performance Report
        ad_relevance_hist                    as ad_relevance_hist,
        landing_page_experience_hist         as landing_page_experience_hist,
        qual_score_hist                      as qual_score_hist,
        expected_clickthrough_rate_hist      as expected_clickthrough_rate_hist,
        search_abs_top_is                    as search_abs_top_is,
        search_lost_abs_top_is_budget        as search_lost_abs_top_is_budget,
        search_lost_top_is_budget            as search_lost_top_is_budget,
        search_exact_match_is                as search_exact_match_is,
        search_impr_share                    as search_impr_share,
        search_lost_abs_top_is_rank          as search_lost_abs_top_is_rank,
        search_lost_is_rank                  as search_lost_is_rank,
        search_lost_top_is_rank              as search_lost_top_is_rank,
        search_top_is                        as search_top_is,

        -- Additional info about the Keywords
        keyword_id                           as keyword_id,
        keyword_state                        as keyword_status,

        criterion_serving_status             as criterion_serving_status,
        match_type                           as match_type,
        destination_url                      as destination_url,

        top_of_page_cpc                      as top_of_page_cpc,
        first_page_cpc                       as first_page_cpc,

        -- Account Timezone and last time this report was updated
        time_zone                            as account_time_zone,

        _sdc_report_datetime                 as updated_at

    from source

)

select *

from renamed

order by
  report_date asc,
  keyword asc
