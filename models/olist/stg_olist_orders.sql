with orders as(
    select * from 
{{ source ('raw_olist','raw_olist_orders') }}
),

cleaned_orders as(
    select
    order_id,
    coalesce(customer_id, 'Unknown') as  customer_id,
    coalesce(order_status, 'Unknown') as order_status,
    date(timestamp(order_purchase_timestamp))  as order_purchase,
    date(timestamp(order_approved_at)) as order_approved,
    date(timestamp(order_delivered_carrier_date)) as order_delivered_carrier_date,
    date(timestamp(order_delivered_customer_date)) as order_delivered_customer_date,
    date(timestamp(order_estimated_delivery_date)) as order_estimated_delivery_date
    from orders
)

select *  from cleaned_orders
