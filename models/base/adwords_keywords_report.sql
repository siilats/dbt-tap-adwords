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

        -- Additional info
        keyword_id                           as keyword_id,
        keyword_state                        as keyword_status,

        criterion_serving_status             as criterion_serving_status,
        match_type                           as match_type,
        destination_url                      as destination_url,

        top_of_page_cpc                      as top_of_page_cpc,
        first_page_cpc                       as first_page_cpc,

        time_zone                            as account_time_zone,

        _sdc_report_datetime                 as updated_at

    from source

)

select *

from renamed

order by
  report_date asc,
  keyword asc
