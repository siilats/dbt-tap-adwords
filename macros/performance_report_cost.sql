{%- macro performance_report_cost (column_name) -%}

    -- Values of cost can be:
    -- a) a money amount in micros
    -- b) "auto: x" or "auto" if Google Ads is automatically setting the bid via the chosen bidding strategy
    -- c) "--" if this field is a bid and no bid applies to the row.
    case
        -- Never trust APIs, let's make sure that we got a number here (intentional check for number, not int)
        when trim(from {{ column_name }}) ~ '^\d+(.\d+)?$'
            then round( trim(from {{ column_name }})::numeric / 1000000, 6)
        when {{ column_name }} = '--' or {{ column_name }} = 'auto'
            then NULL
        when {{ column_name }} like 'auto:%' and (trim(from substring({{ column_name }} from 6)) ~ '^\d+(.\d+)?$')
            then round( trim(from substring({{ column_name }} from 6))::numeric / 1000000, 6)
        else
            NULL
    end

{%- endmacro -%}
