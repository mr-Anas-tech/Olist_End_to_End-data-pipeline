with geolocation as(
   select * from
{{ source('raw_olist','raw_olist_geolocation') }} 
),

geo as(
    select 
    coalesce(geolocation_zip_code_prefix, 0) as geolocation_zip_code_prefix,
    geolocation_lat as geolocation_latitude,
    geolocation_lng as geolocation_longitude,
    trim(lower(coalesce(geolocation_city, 'Unknown'))) as geolocation_city,
    coalesce(geolocation_state, 'Unknown') as geolocation_state
    from geolocation
)

select * from geo