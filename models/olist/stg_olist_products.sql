with products As(
    select * from 
    {{ source('raw_olist','raw_olist_products')}}
),

clean_products as(
    select  
    product_id,
    coalesce(product_category_name, 'Unkown') as product_category_name,
    coalesce(product_name_lenght, 0)  as product_name_lenght,
    coalesce(product_description_lenght, 0) as product_description_lenght,
    coalesce(product_photos_qty, 0) as product_photos_qty,
    coalesce(product_weight_g, 0) as product_weight_g,
    coalesce(product_height_cm, 0) as product_height_cm,
    coalesce(product_width_cm,  0) as product_width_cm
    from  products
)

select  *  from clean_products