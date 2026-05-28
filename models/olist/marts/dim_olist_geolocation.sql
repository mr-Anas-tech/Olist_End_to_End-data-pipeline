{{ config(
    materialized='table'
) }}

with geolocation as(
    select * from
    {{ ref('stg_olist_geolocation') }}
),

final as(
    select 
    geolocation_zip_code_prefix,
    geolocation_latitude,
    geolocation_longitude,
    regexp_replace(geolocation_city, r'([a-z]{3,})(paulo|janerio|horizonte|alegre|grande|vistal|grosso)', r'\1 \2') AS geolocation_city,
    geolocation_state
    from geolocation
)

select * from final