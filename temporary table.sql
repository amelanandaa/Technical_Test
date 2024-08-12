BEGIN;
CREATE TEMPORARY TABLE report_monthly_orders_product_agg AS
SELECT 
  oi.product_id, 
  p.name as product_name, 
  p.category, 
  p.brand, 
  p.department, 
  p.cost, 
  p.retail_price,
  SUM(oi.sale_price) AS total_sales,
  SUM(o.num_of_item) as total_item,  
  FORMAT_TIMESTAMP('%Y-%m',oi.created_at) AS year_month
FROM `bigquery-public-data.thelook_ecommerce.products` as p
JOIN `bigquery-public-data.thelook_ecommerce.order_items` as oi
ON p.id = oi.product_id
JOIN `bigquery-public-data.thelook_ecommerce.orders` as o
ON oi.order_id = o.order_id
WHERE oi.status IN ('Complete', 'Shipped')
GROUP BY
  oi.product_id, 
  p.name, 
  p.category, 
  p.brand, 
  p.department, 
  p.cost, 
  p.retail_price,
  year_month
ORDER BY year_month ASC

/*
BEGIN : Query ini digunakan untuk memulai sesi. Namun kode ini terkadang dilakukan secara tidak eskplisit
CREATE TEMPORARY TABLE report_monthly_orders_product_agg AS : Query ini digunakan untuk membuat tabel sementara
SELECT : Query ini digunakan untuk memilih kolom mana saja yang akan ditambahkan kedalam tabel sementara yang sudah dibuat. Dalam hal ini terdapat
  - product_id
  - product_name
  - category
  - brand
  - department
  - cost
  - retail_price
  - total_sales
  - total_item
  - year_month
SUM(oi.sale_price) AS total_sales dan total_item : fungsi agregat untuk menghitung jumlah dari sales dan item yang terjual
FORMAT_TIMESTAMP ('%Y-%m',oi.created_at) AS year_month : Digunakan untuk mengubah date time hanya menjadi tahun dan bulan
FROM `bigquery-public-data.thelook_ecommerce.products` as p : Query ini digunakan sebagai sumber data
JOIN `bigquery-public-data.thelook_ecommerce.order_items` as oi : Query ini digunakan untuk menggabungkan sumber data yang lain dengan FROM
ON p.id = oi.product_id : Karena terdapat data yang digabungkan, query ini digunakan untuk memastikan data yang digabung tersebut sesuai
WHERE oi.status IN ('Complete', 'Shipped') : Untuk memilih data dengan status complete atau shipped
GROUP BY : Untuk melakukan grup berdasarkan kolom yang sudah dibuat
ORDER BY year_month ASC : Untuk mengurutkan data berdasarkan year_month secara ASC (Ascending) yang berarti mulai dari tanggal paling awal
*/
