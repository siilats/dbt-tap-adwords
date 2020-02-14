with source as (

    select * from {{var('schema')}}.ads

),

renamed as (

    select

        -- Keys
        _sdc_customer_id::bigint                    as account_id,
        base_campaign_id                            as base_campaign_id,
        ad_group_id                                 as ad_group_id,

        base_ad_group_id                            as base_ad_group_id,

        -- Ad Info
        status                                      as ad_status,

        policy_summary__review_state                as review_state,
        policy_summary__combined_approval_status    as combined_approval_status,
        policy_summary__denormalized_status         as denormalized_status,

        trademark_disapproved                       as trademark_disapproved

    from source

)

select * from renamed
