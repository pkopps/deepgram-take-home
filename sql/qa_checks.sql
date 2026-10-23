-- One row of data-quality checks: duplicates, flag mismatches, and dates that fall out of order.
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT user_id) AS distinct_users,
    (
        SELECT COALESCE(SUM(c - 1), 0) FROM (
            SELECT COUNT(*) AS c
            FROM signups_raw
            GROUP BY user_id, signup_date, email_domain, email_type, first_api_call_date,
                     total_credit_spend_usd, days_active, primary_product, products_used,
                     integration_method, purchased, purchase_date, became_sql, sql_date,
                     monthly_usage_pattern
            HAVING COUNT(*) > 1
        )
    ) AS duplicate_rows,
    MIN(spend) AS min_spend,
    MIN(days) AS min_days,
    SUM(CASE WHEN spend > 0 AND activated = 0 THEN 1 ELSE 0 END) AS spend_without_call,
    SUM(CASE WHEN activated = 1 AND NOT (spend > 0 AND days > 0) THEN 1 ELSE 0 END) AS call_without_spend,
    SUM(CASE WHEN purchased = 1 AND purchase_dt IS NULL THEN 1
             WHEN purchased = 0 AND purchase_dt IS NOT NULL THEN 1
             ELSE 0 END) AS purch_flag_mismatch,
    SUM(CASE WHEN sql_flag = 1 AND sql_dt IS NULL THEN 1
             WHEN sql_flag = 0 AND sql_dt IS NOT NULL THEN 1
             ELSE 0 END) AS sql_flag_mismatch,
    SUM(CASE WHEN integration_method = 'none' AND activated = 1 THEN 1 ELSE 0 END) AS none_with_call,
    SUM(CASE WHEN integration_method != 'none' AND activated = 0 THEN 1 ELSE 0 END) AS method_without_call,
    SUM(CASE WHEN activated = 1 AND primary_product IS NULL THEN 1 ELSE 0 END) AS primary_missing,
    SUM(CASE WHEN activated = 0 AND primary_product IS NOT NULL THEN 1 ELSE 0 END) AS primary_when_idle,
    MAX(ABS(pattern_sum - spend)) AS max_pattern_gap,
    SUM(CASE
        WHEN activated = 1 AND primary_product IS NOT NULL
             AND (',' || products_used || ',') NOT LIKE '%,' || primary_product || ',%' THEN 1
        ELSE 0
    END) AS primary_not_in_list,
    SUM(CASE WHEN activated = 1 AND first_call < signup THEN 1 ELSE 0 END) AS call_before_signup,
    SUM(CASE WHEN purchased = 1 AND purchase_dt < signup THEN 1 ELSE 0 END) AS purch_before,
    SUM(CASE WHEN purchased = 1 AND activated = 0 THEN 1 ELSE 0 END) AS buy_no_call,
    SUM(CASE WHEN sql_flag = 1 AND sql_dt < signup THEN 1 ELSE 0 END) AS sql_before,
    SUM(CASE WHEN sql_flag = 1 AND purchased = 0 THEN 1 ELSE 0 END) AS sql_no_buy,
    SUM(CASE WHEN spend > 200 THEN 1 ELSE 0 END) AS over_grant,
    SUM(CASE WHEN first_call IS NOT NULL AND purchase_dt IS NOT NULL AND first_call > purchase_dt THEN 1 ELSE 0 END) AS call_after_buy,
    SUM(CASE WHEN signup_month = '2026-03' THEN 1 ELSE 0 END) AS march_signups,
    MAX(spend) AS max_spend
FROM accounts;
