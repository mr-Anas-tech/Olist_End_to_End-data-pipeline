{{ config(
    materialized='table'
) }}

with sellers as (
    select * from {{ ref('stg_olist_seller') }}
),

final as(
select
    seller_id,
    coalesce(seller_zip_code_prefix, 0) as seller_zip_code_prefix,
    coalesce(seller_city, 'Unknown') as seller_city,
    coalesce(seller_state, 'Unknown') as seller_state
from sellers
)

select * from final