-- Min, median, mean, and max for spend, days active, and number of products.
SELECT 'spend' AS metric, COUNT(spend) AS n, MIN(spend) AS min_value,
       (
           SELECT AVG(spend) FROM (
               SELECT spend FROM accounts ORDER BY spend
               LIMIT 2 - ((SELECT COUNT(*) FROM accounts) % 2)
               OFFSET ((SELECT COUNT(*) FROM accounts) - 1) / 2
           )
       ) AS median_value,
       AVG(spend) AS mean_value, MAX(spend) AS max_value
FROM accounts
UNION ALL
SELECT 'days', COUNT(days), MIN(days),
       (
           SELECT AVG(days) FROM (
               SELECT days FROM accounts ORDER BY days
               LIMIT 2 - ((SELECT COUNT(*) FROM accounts) % 2)
               OFFSET ((SELECT COUNT(*) FROM accounts) - 1) / 2
           )
       ),
       AVG(days), MAX(days)
FROM accounts
UNION ALL
SELECT 'n_products', COUNT(n_products), MIN(n_products),
       (
           SELECT AVG(n_products) FROM (
               SELECT n_products FROM accounts ORDER BY n_products
               LIMIT 2 - ((SELECT COUNT(*) FROM accounts) % 2)
               OFFSET ((SELECT COUNT(*) FROM accounts) - 1) / 2
           )
       ),
       AVG(n_products), MAX(n_products)
FROM accounts;
