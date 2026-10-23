-- How many accounts fall in each value of the short category columns.
SELECT 'email_type' AS column_name, email_type AS value, COUNT(*) AS people
FROM signups_raw
GROUP BY email_type
UNION ALL
SELECT 'primary_product', CASE WHEN TRIM(primary_product) = '' THEN '(blank)' ELSE primary_product END, COUNT(*)
FROM signups_raw
GROUP BY 2
UNION ALL
SELECT 'integration_method', integration_method, COUNT(*)
FROM signups_raw
GROUP BY integration_method
UNION ALL
SELECT 'purchased', purchased, COUNT(*)
FROM signups_raw
GROUP BY purchased
UNION ALL
SELECT 'became_sql', became_sql, COUNT(*)
FROM signups_raw
GROUP BY became_sql
ORDER BY column_name, people DESC;
