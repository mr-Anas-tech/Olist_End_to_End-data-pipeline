with customers as(
    select * from 
    {{ source('raw_olist','raw_olist_customers') }}
),

clean_customers as(
    select
    customer_id,
    coalesce(customer_unique_id, 'Unknown') as customer_unique_id,
    coalesce(customer_zip_code_prefix, 0) as customer_zip_code_prefix,
    coalesce(customer_city, 'Unknown') AS customer_city,
    coalesce(customer_state, 'Unknown') AS customer_state
    from customers
)

select * from clean_customers