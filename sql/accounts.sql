-- Build the accounts view: typed columns, product count, and the never-started / tried-it / building label.
DROP VIEW IF EXISTS accounts;

CREATE VIEW accounts AS
WITH base AS (
    SELECT
        user_id,
        signup_date AS signup,
        email_domain,
        email_type,
        NULLIF(TRIM(first_api_call_date), '') AS first_call,
        CAST(total_credit_spend_usd AS REAL) AS spend,
        CAST(days_active AS INTEGER) AS days,
        NULLIF(TRIM(primary_product), '') AS primary_product,
        NULLIF(TRIM(products_used), '') AS products_used,
        integration_method,
        CASE WHEN purchased = 'True' THEN 1 ELSE 0 END AS purchased,
        NULLIF(TRIM(purchase_date), '') AS purchase_dt,
        CASE WHEN became_sql = 'True' THEN 1 ELSE 0 END AS sql_flag,
        NULLIF(TRIM(sql_date), '') AS sql_dt,
        CASE
            WHEN TRIM(products_used) = '' THEN 0
            ELSE LENGTH(products_used) - LENGTH(REPLACE(products_used, ',', '')) + 1
        END AS n_products,
        COALESCE((
            SELECT SUM(j.value)
            FROM json_each(
                CASE
                    WHEN TRIM(s.monthly_usage_pattern) = '' THEN '[]'
                    ELSE s.monthly_usage_pattern
                END
            ) AS j
        ), 0) AS pattern_sum
    FROM signups_raw AS s
)
SELECT
    base.*,
    CASE WHEN first_call IS NULL THEN 0 ELSE 1 END AS activated,
    CASE
        WHEN first_call IS NULL THEN 'Never started'
        WHEN integration_method IN ('sdk', 'direct_api')
             AND (days >= 3 OR n_products >= 2) THEN 'Building'
        ELSE 'Tried it'
    END AS cohort,
    SUBSTR(signup, 1, 7) AS signup_month,
    CASE
        WHEN purchased = 1 AND purchase_dt IS NOT NULL AND purchase_dt >= signup THEN 1
        ELSE 0
    END AS bought_after_signup
FROM base;
