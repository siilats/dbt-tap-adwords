{%- macro performance_report_dimensions() -%}

        customer_id               as account_id,
        account                   as account_name,

        campaign_id               as campaign_id,
        campaign                  as campaign_name,
        campaign_state            as campaign_status,

        ad_group_id               as ad_group_id,
        ad_group                  as ad_group_name,
        ad_group_state            as ad_group_status,

        client_name               as client_name

{%- endmacro -%}
