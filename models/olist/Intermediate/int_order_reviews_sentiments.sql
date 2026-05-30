{{ config(
    materialized='view'
    ) }}

with reviews AS(
    select *  from
    {{ ref('olist_reviews') }}
),

final as(
    select
    order_id,
    avg(coalesce(review_score, 0)) as average_review_score,
    case 
    when avg(review_score)>=4 then 'Positive'
    when avg(review_score)=3 then 'Neutral'
    else 'Negative'
    end AS review_sentiment,
    sum(case when review_comment_message is not null and review_comment_message !='Unknown' then 1 end) AS
    total_feedback_comments
    from reviews 
    where order_id is not null and order_id !='Unknown'
    group by 1
)

select * from final