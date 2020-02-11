with source as (

    select * from {{var('schema')}}.keywords_performance_report

),

renamed as (

    select

        -- FKeys to base entities
        _sdc_customer_id::int as account_id,
        account as account_name,

        campaign_id as campaign_id,
        campaign as campaign_name,
        campaign_state as campaign_status,

        ad_group_id as ad_group_id,
        ad_group as ad_group_name,
        ad_group_state as ad_group_status,

        client_name as client_name,

        -- Report Segments
        day::date as report_date,
        keyword as keyword,

        -- Core Metrics
        clicks as clicks,

        round( cost::int * 1.0 / 1000000, 6) as cost,
        currency as currency,

        impressions as impressions,
        interactions as interactions,

        engagements as engagements,
        conversions as conversions,

        -- Additional Metrics
        all_conv as all_conversions,
        views as video_views,

        active_view_viewable_impressions as active_view_viewable_impressions,
        active_view_measurable_impr as active_view_measurable_impr,
        active_view_measurable_cost as active_view_measurable_cost,

        gmail_clicks_to_website as gmail_clicks_to_website,
        gmail_saves as gmail_saves,
        gmail_forwards as gmail_forwards,

        -- Additional info
        keyword_id as keyword_id,
        keyword_state as keyword_status,

        criterion_serving_status as criterion_serving_status,
        match_type as match_type,
        destination_url as destination_url,

        time_zone as account_time_zone,

        _sdc_report_datetime as updated_at

    from source

)

select * from renamed

order by
  report_date asc,
  keyword asc
