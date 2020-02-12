{%- macro performance_report_metrics() -%}

        -- Core Metrics
        clicks                              as clicks,

        {{ tap_adwords.performance_report_cost('cost') }} as cost,

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
        gmail_forwards                      as gmail_forwards

{%- endmacro -%}
