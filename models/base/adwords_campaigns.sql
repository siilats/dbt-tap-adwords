with source as (

    select * from {{var('schema')}}.campaigns

),

renamed as (

    select

        -- PK
        id as ad_campaign_id,

        -- FKeys
        _sdc_customer_id::int as account_id,
        base_campaign_id as base_campaign_id,
        budget_id as budget_id,

        -- Campaign Info
        name as campaign_name,

        status as campaign_status,

        serving_status as serving_status,
        ad_serving_optimization_status as optimization_status,
        advertising_channel_type as advertising_channel_type,
        campaign_trial_type as trial_type

        start_date as start_date,
        end_date as end_date,

        -- JSONB arrays in case we need them to filter by label or setting value
        labels as labels,
        settings as settings,

    from source

)

select * from renamed
