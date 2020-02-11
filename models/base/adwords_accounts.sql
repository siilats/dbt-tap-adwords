with source as (

    select * from {{var('schema')}}.accounts

),

renamed as (

    select

        customer_id as account_id,

        name as account_name,

        currency_code as currency_code,
        date_time_zone as date_time_zone,

        can_manage_clients as can_manage_clients,
        test_account as test_account

    from source

)

select * from renamed
