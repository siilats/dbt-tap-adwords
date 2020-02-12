with source as (

    select * from {{var('schema')}}.ad_performance_report

),

renamed as (

    select
        -- FKeys to base entities
        _sdc_customer_id::int               as account_id,
        account                             as account_name,

        campaign_id                         as campaign_id,
        campaign                            as campaign_name,
        campaign_state                      as campaign_status,

        ad_group_id                         as ad_group_id,
        ad_group                            as ad_group_name,
        ad_group_state                      as ad_group_status,

        client_name                         as client_name,

        -- Report Segments
        day::date                           as report_date,

        -- Core Metrics
        clicks                              as clicks,

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
        end                                 as cost,

        currency                            as currency,

        impressions                         as impressions,
        interactions                        as interactions,

        engagements                         as engagements,
        conversions                         as conversions,

        -- Additional Metrics
        all_conv                            as all_conversions,
        views                               as video_views,

        active_view_viewable_impressions    as active_view_viewable_impressions,
        active_view_measurable_impr         as active_view_measurable_impr,
        active_view_measurable_cost         as active_view_measurable_cost,

        gmail_clicks_to_website             as gmail_clicks_to_website,
        gmail_saves                         as gmail_saves,
        gmail_forwards                      as gmail_forwards,

        -- Additional info about the Ad
        ad_id                               as ad_id,
        ad_state                            as ad_status,
        approval_status                     as approval_status,
        ad_type                             as ad_type,

        ad_strength                         as ad_strength,
        auto_applied_ad_suggestion          as auto_applied_ad_suggestion,

        final_url                           as final_url,

        ad                                  as text_ad_headline,
        description_line1                   as description_line1,
        description_line2                   as description_line2,
        display_url                         as display_url,

        -- expanded text ad or responsive display ads.
        description                         as description,
        headline1                           as headline1,
        headline2                           as headline2,
        path1                               as path1,

        -- reponsive display ads
        business_name                       as business_name,
        call_to_action_text_responsive      as call_to_action_text_responsive,
        short_headline                      as short_headline,
        long_headline                       as long_headline,
        promotion_text_responsive           as promotion_text_responsive,

        -- responsive search ads
        responsive_search_ad_headlines      as responsive_search_ad_headlines,
        responsive_search_ad_descriptions   as responsive_search_ad_descriptions,
        responsive_search_ad_path1          as responsive_search_ad_path1,

        -- Gmail ads
        gmail_ad_business_name              as gmail_ad_business_name,
        gmail_ad_headline                   as gmail_ad_headline,
        gmail_ad_description                as gmail_ad_description,

        -- Image ads
        image_ad_name                       as image_ad_name,

        -- Will this nightmare of going through all those types of Ads ever end?

        -- Multi Asset Responsive Display Ads
        business_name_multi_asset_responsive_display       as business_name_multi_asset_responsive_display,
        long_headline_multi_asset_responsive_display       as long_headline_multi_asset_responsive_display,
        headlines_multi_asset_responsive_display           as headlines_multi_asset_responsive_display,
        call_to_action_text_multi_asset_responsive_display as call_to_action_text_multi_asset_responsive_display,
        promotion_text_multi_asset_responsive_display      as promotion_text_multi_asset_responsive_display,

        time_zone                           as account_time_zone,

        _sdc_report_datetime                as updated_at

    from source

)

select *

from renamed

order by report_date asc
