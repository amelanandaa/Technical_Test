BEGIN;
CREATE TEMPORARY TABLE report_monthly_orders_product_agg AS
SELECT 
  oi.product_id as product_id, 
  p.name as product_name, 
  p.category, 
  p.brand, 
  p.department, 
  p.cost, 
  p.retail_price,
  oi.sale_price, 
  oi.status,  
  oi.created_at as order_date
FROM `bigquery-public-data.thelook_ecommerce.products` as p
JOIN `bigquery-public-data.thelook_ecommerce.order_items` as oi
ON p.id = oi.product_id