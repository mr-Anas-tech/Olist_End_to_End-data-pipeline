with order_items as(
    select * from 
    {{source('raw_olist','raw_olist_order_items')}}
),

items as (
    select
    order_id,
    coalesce(order_item_id, 0) as customer_id,
    coalesce(product_id, 'Unknown') as product_id,
    coalesce(seller_id, 'Unknown') as seller_id,
    date(timestamp(coalesce(shipping_limit_date, '1970-01-01 00:00:00'))) as shipping_limit_date,
    coalesce(price, percentile_cont(price, 0.5)over()) as price,
    coalesce(freight_value, percentile_cont(freight_value, 0.5)over()) as freight_value
    from order_items
)

select * from items