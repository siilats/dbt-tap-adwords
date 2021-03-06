{%- macro performance_report_metrics() -%}

        -- Core Metrics
        clicks                                     as clicks,

        {{ tap_adwords.performance_report_cost('cost') }} as cost,

        currency                                   as currency,

        impressions                                as impressions,
        interactions                               as interactions,

        engagements                                as engagements,
        conversions                                as conversions,

        -- Additional Metrics
        all_conv                                   as all_conversions,
        views                                      as video_views,

        active_view_viewable_impressions           as active_view_viewable_impressions,
        active_view_measurable_impr                as active_view_measurable_impr,

        {{ tap_adwords.performance_report_cost('active_view_measurable_cost') }} as active_view_measurable_cost,

        gmail_clicks_to_website                    as gmail_clicks_to_website,
        gmail_saves                                as gmail_saves,
        gmail_forwards                             as gmail_forwards,

        -- Metrics Required for compliance with RMF requirements
        impr_abs_top                               as impr_abs_top,

        {{ tap_adwords.performance_report_cost('active_view_avg_cpm') }} as active_view_avg_cpm,

        active_view_viewable_ctr                   as active_view_viewable_ctr,
        active_view_measurable_impr_impr           as active_view_measurable_impr_impr,
        active_view_viewable_impr_measurable_impr  as active_view_viewable_impr_measurable_impr,
        all_conv_rate                              as all_conv_rate,
        all_conv_value                             as all_conv_value,

        {{ tap_adwords.performance_report_cost('avg_cost') }} as avg_cost,
        {{ tap_adwords.performance_report_cost('avg_cpc') }} as avg_cpc,

        avg_cpe                                    as avg_cpe,

        {{ tap_adwords.performance_report_cost('avg_cpm') }} as avg_cpm,

        avg_cpv                                    as avg_cpv,
        avg_position                               as avg_position,
        conv_rate                                  as conv_rate,
        total_conv_value                           as total_conv_value,

        {{ tap_adwords.performance_report_cost('cost_all_conv') }} as cost_all_conv,
        {{ tap_adwords.performance_report_cost('cost_conv') }} as cost_conv,

        cost_conv_current_model                    as cost_conv_current_model,
        cross_device_conv                          as cross_device_conv,
        ctr                                        as ctr,
        conversions_current_model                  as conversions_current_model,
        conv_value_current_model                   as conv_value_current_model,
        engagement_rate                            as engagement_rate,
        interaction_rate                           as interaction_rate,
        interaction_types                          as interaction_types,
        impr_top                                   as impr_top,
        value_all_conv                             as value_all_conv,
        value_conv                                 as value_conv,
        value_conv_current_model                   as value_conv_current_model,
        video_played_to100                         as video_played_to100,
        video_played_to25                          as video_played_to25,
        video_played_to50                          as video_played_to50,
        video_played_to75                          as video_played_to75,
        view_rate                                  as view_rate,
        view_through_conv                          as view_through_conv

{%- endmacro -%}
