select gender, sum(purchase_amount) as revenue
from customer
group by gender;

select customer_id,purchase_amount
from customer
where discount_applied='Yes' 
  and 
  purchase_amount>(select avg(purchase_amount) 
  from customer);

select item_purchased,round(Avg(review_rating::numeric),2) as "Average Product Rating"
from customer
group by item_purchased
order by avg(review_rating) DESC 
  limit 5;

select shipping_type,
  round(avg(purchase_amount),2)
from customer
  where shipping_type in ('Standard', 'Express')
group by shipping_type;

  select
    subscription_status,
    count(subscription_status) as total
    from customer
    group by  subscription_status;

select subscription_status,
count(customer_id) as total_customers,
round(avg(purchase_amount),2) avg_spend,
round(sum(purchase_amount),2) as revenue
from customer
group by subscription_status ;


select item_purchased,
round(100 * sum(case when discount_applied ='Yes' then 1 else 0 end)/count(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate DESC
limit 5;

with customer_type as (
  select customer_id,previous_purchases,
  case when previous_purchases=1 then 'New'
  when previous_purchases between 2 and 10 then 'Returning'
  else 'Loyal'
  end as customer_segment
  from customer
)

select customer_segment,count(customer_id) as "Number of Customers"
from customer_type
group by customer_segment;


with item_counts as (
  select category,
  item_purchased,
  count(customer_id) as total_orders,
  row_number() over(partition by category order by count(customer_id)desc) as item_rank
  from customer
  group by category,item_purchased
)

select item_rank,category,item_purchased,total_orders
from item_counts
where item_rank<=3;

select count(customer_id) as Total_customer,
  previous_purchases,subscription_status
  
from customer
where subscription_status='Yes' and previous_purchases>5
group by  previous_purchases,subscription_status
  order by total_customer desc, previous_purchases desc;

select count(customer_id) as Repeat_buyers,
 sum(previous_purchases) as total_pre_purchases ,subscription_status
  
from customer
where previous_purchases>5
group by subscription_status
  order by count(customer_id) desc;

select age_group,
sum(purchase_amount) as revenue
  from customer
group by age_group
order by revenue desc;

