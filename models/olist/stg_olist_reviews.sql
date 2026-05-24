with reviews AS(
    select*from 
    {{ source('raw_olist','raw_olist_reviews') }}
),

clean_reviews  as(
    select 
    review_id,
    coalesce(order_id, 'Unknown') as order_id,
    coalesce(review_score, 0) as review_score,
    coalesce(review_comment_message, 'Unknown') as review_comment_message,
    date(timestamp(coalesce(review_creation_date, '1970-01-01 00:00:00'))) as review_creation_date,
    date(timestamp(coalesce(review_answer_timestamp, '1970-01-01 00:00:00'))) as review_answer_timestamp
    from reviews
)

select * from clean_reviews