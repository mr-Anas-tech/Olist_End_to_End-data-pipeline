{{ config(
     materialized='view'
) }}

with order_items as(
    select * from
    {{ ref('olist_orders_items') }}
),

payment as(
    select * from
    {{ ref('olist_payment') }}
),

agg_items as(
    select 
    order_id,
    sum(price) as total_price,
    sum(freight_value) as total_freight_value
    from order_items
    group by 1 
),

agg_payment as(
    select
    order_id,
    sum(payment_value) as total_amount_paid,
    max(payment_installments) max_payment_installments,
    from payment group by 1
),

final as(
    select 
    i.order_id,
    i.total_price,
    p.total_amount_paid,
    i.total_freight_value,
    case 
    when total_price>0 
    then (i.total_freight_value/i.total_price) * 100
    else 0
    end as freight_percentage_of_price,
    case 
    when p.max_payment_installments > 1 then True 
    else False
    end as is_installment_payments
    from agg_items i
    left join agg_payment p
    ON i.order_id=p.order_id
)

select * from final