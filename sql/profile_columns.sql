-- Blank count and distinct-value count for every column in the raw signup file.
SELECT 'user_id' AS column_name,
       SUM(CASE WHEN TRIM(user_id) = '' THEN 1 ELSE 0 END) AS blanks,
       COUNT(DISTINCT NULLIF(TRIM(user_id), '')) AS unique_values
FROM signups_raw
UNION ALL
SELECT 'signup_date',
       SUM(CASE WHEN TRIM(signup_date) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(signup_date), ''))
FROM signups_raw
UNION ALL
SELECT 'email_domain',
       SUM(CASE WHEN TRIM(email_domain) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(email_domain), ''))
FROM signups_raw
UNION ALL
SELECT 'email_type',
       SUM(CASE WHEN TRIM(email_type) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(email_type), ''))
FROM signups_raw
UNION ALL
SELECT 'first_api_call_date',
       SUM(CASE WHEN TRIM(first_api_call_date) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(first_api_call_date), ''))
FROM signups_raw
UNION ALL
SELECT 'total_credit_spend_usd',
       SUM(CASE WHEN TRIM(total_credit_spend_usd) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(total_credit_spend_usd), ''))
FROM signups_raw
UNION ALL
SELECT 'days_active',
       SUM(CASE WHEN TRIM(days_active) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(days_active), ''))
FROM signups_raw
UNION ALL
SELECT 'primary_product',
       SUM(CASE WHEN TRIM(primary_product) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(primary_product), ''))
FROM signups_raw
UNION ALL
SELECT 'products_used',
       SUM(CASE WHEN TRIM(products_used) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(products_used), ''))
FROM signups_raw
UNION ALL
SELECT 'integration_method',
       SUM(CASE WHEN TRIM(integration_method) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(integration_method), ''))
FROM signups_raw
UNION ALL
SELECT 'purchased',
       SUM(CASE WHEN TRIM(purchased) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(purchased), ''))
FROM signups_raw
UNION ALL
SELECT 'purchase_date',
       SUM(CASE WHEN TRIM(purchase_date) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(purchase_date), ''))
FROM signups_raw
UNION ALL
SELECT 'became_sql',
       SUM(CASE WHEN TRIM(became_sql) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(became_sql), ''))
FROM signups_raw
UNION ALL
SELECT 'sql_date',
       SUM(CASE WHEN TRIM(sql_date) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(sql_date), ''))
FROM signups_raw
UNION ALL
SELECT 'monthly_usage_pattern',
       SUM(CASE WHEN TRIM(monthly_usage_pattern) = '' THEN 1 ELSE 0 END),
       COUNT(DISTINCT NULLIF(TRIM(monthly_usage_pattern), ''))
FROM signups_raw;
