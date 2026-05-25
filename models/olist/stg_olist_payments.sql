with payments as(
    select * from
{{ source('raw_olist','raw_olist_payments') }}
),

c_payment as(
    select
    order_id,
    coalesce(payment_sequential, 0) As payment_sequential,
    coalesce(payment_type, 'Unknown') as payment_method,
    coalesce(payment_installments, 0) as payment_installments,
    coalesce(payment_value, 0) as payment_value
    from payments
)

select * from c_payment