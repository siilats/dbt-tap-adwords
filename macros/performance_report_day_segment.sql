{%- macro performance_report_day_segment() -%}

        day::date                           as report_date,

        -- Date parts for easy grouping
        EXTRACT(DAY FROM day::date)         as report_date_day,
        EXTRACT(WEEK FROM day::date)        as report_date_week,
        EXTRACT(MONTH FROM day::date)       as report_date_month,
        EXTRACT(QUARTER FROM day::date)     as report_date_quarter,
        EXTRACT(YEAR FROM day::date)        as report_date_year,
        EXTRACT(ISOYEAR FROM day::date)     as report_date_iso_year

{%- endmacro -%}
