with orders as(
    select * from 
{{ source ('raw_olist','raw_olist_orders') }}
),

cleaned_orders as(
    select
    order_id,
    coalesce(customer_id, 'Unknown') as  customer_id,
    coalesce(order_status, 'Unknown') as customer_status,
    date(timestamp(coalesce(order_purchase_timestamp, '1970-01-01 00:00:00')))  as order_purchase,
    date(timestamp(coalesce(order_approved_at, '1970-01-01 00:00:00'))) as order_approved,
    date(timestamp(coalesce(order_delivered_carrier_date, '1970-01-01 00:00:00'))) as order_delivered_carrier_date,
    date(timestamp(coalesce(order_delivered_customer_date,'1970-01-01 00:00:00'))) as oorder_delivered_customer_date,
    date(timestamp(coalesce(order_estimated_delivery_date, '1970-01-01 00:00:00'))) as order_estimated_delivery_date
    from orders
)

select *  from cleaned_orders
