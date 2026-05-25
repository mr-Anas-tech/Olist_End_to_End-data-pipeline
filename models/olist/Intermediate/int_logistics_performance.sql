with orders as(
    select * from
    {{ ref('stg_olist_orders') }}  
),

order_items AS(
    select * from
    {{ ref('stg_olist_order_items') }}
),

final As(
    select
    o.order_id,
    oi.order_item_id,
    date_diff(o.order_delivered_customer_date, o.order_purchase, day) as actual_delivery_time_days,
    date_diff(o.order_estimated_delivery_date, o.order_purchase, day) as order_estimated_delivery_time_days,
    case 
    when o.order_delivered_customer_date>o.order_estimated_delivery_date
    then date_diff(o.order_delivered_customer_date,o.order_estimated_delivery_date,day)
    else 0
    end as delivery_delay_days,
    case 
    when o.order_delivered_customer_date>o.order_estimated_delivery_date then
    True else False end as is_late_delivery,
    case 
    when o.order_delivered_carrier_date>oi.shipping_limit_date then 'Delay by seller'
    when o.order_delivered_carrier_date is null then 'Not yet shipped'
    else 'On time by seller' end As
    seller_shipment_status
    from orders o
    left join order_items oi
    on o.order_id=oi.order_id
    Where o.order_status='delivered'
)

select * from final