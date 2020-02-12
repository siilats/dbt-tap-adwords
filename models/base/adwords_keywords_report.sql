with source as (

    select * from {{var('schema')}}.keywords_performance_report

),

renamed as (

    select

        -- FKeys to base entities
        _sdc_customer_id::int                as account_id,
        account                              as account_name,

        campaign_id                          as campaign_id,
        campaign                             as campaign_name,
        campaign_state                       as campaign_status,

        ad_group_id                          as ad_group_id,
        ad_group                             as ad_group_name,
        ad_group_state                       as ad_group_status,

        client_name                          as client_name,

        -- Report Segments
        day::date                            as report_date,
        keyword                              as keyword,

        -- Core Metrics
        clicks                               as clicks,

        -- Values of cost can be:
        -- a) a money amount in micros
        -- b) "auto: x" or "auto" if Google Ads is automatically setting the bid via the chosen bidding strategy
        -- c) "--" if this field is a bid and no bid applies to the row.
        case
            -- Never trust APIs, let's make sure that we got a number here (intentional check for number, not int)
            when trim(from cost) ~ '^\d+(.\d+)?$'
                then round( trim(from cost)::int * 1.0 / 1000000, 6)
            when cost = '--' or cost = 'auto'
                then NULL
            when cost like 'auto:%' and (trim(from substring(cost from 6)) ~ '^\d+(.\d+)?$')
                then round( trim(from substring(cost from 6))::int * 1.0 / 1000000, 6)
            else
                NULL
        end                                  as cost,

        currency                             as currency,

        impressions                          as impressions,
        interactions                         as interactions,

        engagements                          as engagements,
        conversions                          as conversions,

        -- Additional Metrics
        all_conv                             as all_conversions,
        views                                as video_views,

        active_view_viewable_impressions     as active_view_viewable_impressions,
        active_view_measurable_impr          as active_view_measurable_impr,
        active_view_measurable_cost          as active_view_measurable_cost,

        gmail_clicks_to_website              as gmail_clicks_to_website,
        gmail_saves                          as gmail_saves,
        gmail_forwards                       as gmail_forwards,

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
