{{ config(
    materialized='table'
) }}

with orders as (
    select * from {{ ref('stg_olist_orders') }}
),

logistics as (
    select * from {{ ref('int_logistics_performance') }}
),

payment as (
    select * from {{ ref('int_order_payment_financial') }}
),

reviews as (
    select * from {{ ref('int_order_reviews_sentiments') }}
),

order_item as(
    select * from 
    {{ ref('stg_olist_order_items') }}
),joined as (
    select
        o.order_id,
        o.customer_id,
        coalesce(oi.product_id, 'Unknown') as product_id,
        o.order_status,
        coalesce(cast(o.order_purchase as date), date('1900-01-01')) as order_purchase,
        coalesce(cast(o.order_approved as date), date('1900-01-01')) as order_approved,
        coalesce(l.actual_delivery_time_days, 0) as actual_delivery_time_days,
        coalesce(l.order_estimated_delivery_time_days, 0) as order_estimated_delivery_time_days,
        coalesce(l.delivery_delay_days, 0) as delivery_delay_days,
        coalesce(l.is_late_delivery, 0) as is_late_delivery,
        coalesce(l.seller_shipment_status, 'Not_shipped') as seller_shipment_status,
        coalesce(p.total_price, 0) as total_price,
        coalesce(p.total_amount_paid, 0) as total_amount_paid,
        coalesce(p.total_freight_value, 0) as total_freight_value,
        coalesce(p.freight_percentage_of_price, 0) as freight_percentage_of_price,
        coalesce(p.is_installment_payments, false) as is_installment_payments,
        coalesce(r.average_review_score, 0) as average_review_score,
        coalesce(r.review_sentiment, 'No review') as review_sentiment,
        coalesce(r.total_feedback_comments, 0) as total_feedback_comments,
        row_number() over (
            partition by o.order_id
            order by o.order_purchase desc
        ) as rn
    from orders o
    left join logistics l on o.order_id = l.order_id
    left join payment p on o.order_id = p.order_id
    left join reviews r on o.order_id = r.order_id
    left join order_item oi on oi.order_id=o.order_id
)

select
    order_id,
    customer_id,
    product_id,
    order_status,
    order_purchase,
    order_approved,
    actual_delivery_time_days,
    order_estimated_delivery_time_days,
    delivery_delay_days,
    is_late_delivery,
    seller_shipment_status,
    total_price,
    total_amount_paid,
    total_freight_value,
    freight_percentage_of_price,
    is_installment_payments,
    average_review_score,
    review_sentiment,
    total_feedback_comments
from joined
where rn = 1