{{ config(
    materialized='table'
) }}

with products as (
    select * from {{ ref('stg_olist_products') }}
),

final as(
select
    product_id,
    coalesce(product_category_name, 'No Category') as product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_height_cm,
    product_width_cm
from products
)

select * from final