
-- Customer Behavior Analysis


-- Revenue by Gender
SELECT gender, 
       SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender;

-- High Value Customers with Discount
SELECT customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes' 
  AND purchase_amount > (
      SELECT AVG(purchase_amount) 
      FROM customer
  );

-- Top 5 Products by Average Rating
SELECT item_purchased, 
       ROUND(AVG(review_rating::numeric), 2) AS "Average Product Rating"
FROM customer
GROUP BY item_purchased
ORDER BY AVG(review_rating) DESC
LIMIT 5;

-- Average Spend by Shipping Type
SELECT shipping_type,
       ROUND(AVG(purchase_amount), 2)
FROM customer
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type;

--  Subscription Status Count
SELECT subscription_status,
       COUNT(subscription_status) AS total
FROM customer
GROUP BY subscription_status;

-- Revenue & Spend by Subscription Status
SELECT subscription_status,
       COUNT(customer_id) AS total_customers,
       ROUND(AVG(purchase_amount), 2) AS avg_spend,
       ROUND(SUM(purchase_amount), 2) AS revenue
FROM customer
GROUP BY subscription_status;

-- Top 5 Items by Discount Rate
SELECT item_purchased,
       ROUND(100 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

-- Customer Segmentation (New / Returning / Loyal)
WITH customer_type AS (
    SELECT customer_id, 
           previous_purchases,
           CASE 
               WHEN previous_purchases = 1 THEN 'New'
               WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
               ELSE 'Loyal'
           END AS customer_segment
    FROM customer
)
SELECT customer_segment, 
       COUNT(customer_id) AS "Number of Customers"
FROM customer_type
GROUP BY customer_segment;

-- Top 3 Items per Category
WITH item_counts AS (
    SELECT category,
           item_purchased,
           COUNT(customer_id) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM customer
    GROUP BY category, item_purchased
)
SELECT item_rank, category, item_purchased, total_orders
FROM item_counts
WHERE item_rank <= 3;

-- Loyal Subscribers (Subscribed + 5+ Purchases)
SELECT COUNT(customer_id) AS total_customer,
       previous_purchases,
       subscription_status
FROM customer
WHERE subscription_status = 'Yes' 
  AND previous_purchases > 5
GROUP BY previous_purchases, subscription_status
ORDER BY total_customer DESC, previous_purchases DESC;

-- Repeat Buyers by Subscription Status
SELECT COUNT(customer_id) AS repeat_buyers,
       SUM(previous_purchases) AS total_pre_purchases,
       subscription_status
FROM customer
WHERE previous_purchases > 5
GROUP BY subscription_status
ORDER BY COUNT(customer_id) DESC;

-- Revenue by Age Group
SELECT age_group,
       SUM(purchase_amount) AS revenue
FROM customer
GROUP BY age_group
ORDER BY revenue DESC;
