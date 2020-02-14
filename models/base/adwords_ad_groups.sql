with source as (

    select * from {{var('schema')}}.ad_groups

),

renamed as (

    select

        -- PK
        id                        as ad_group_id,

        -- FKeys
        _sdc_customer_id::bigint  as account_id,
        campaign_id               as campaign_id,

        base_ad_group_id          as base_ad_group_id,
        base_campaign_id          as base_campaign_id,

        -- Ad Group Info
        campaign_name             as campaign_name,
        name                      as ad_group_name,

        ad_group_type             as ad_group_type,
        status                    as ad_group_status

    from source

)

select * from renamed
