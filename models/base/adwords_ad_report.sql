with source as (

    select * from {{var('schema')}}.ad_performance_report

),

renamed as (

    select

        -- Dimensions common in all Performance Reports
        {{ tap_adwords.performance_report_dimensions() }},

        -- Report Segments
        day::date                           as report_date,

        -- Metrics common in all Performance Reports
        {{ tap_adwords.performance_report_metrics() }},

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
