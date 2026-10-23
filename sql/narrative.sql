-- One row of the extra counts the summary sentences need: buyer spend, email starts and buys, and date checks.
SELECT
    SUM(CASE WHEN activated = 1 AND purchased = 1 THEN 1 ELSE 0 END) AS try_buy_n,
    SUM(CASE WHEN activated = 1 AND purchased = 1 THEN spend ELSE 0 END) AS try_buy_spend,
    SUM(CASE WHEN purchased = 1 THEN spend ELSE 0 END) AS buyer_spend,
    SUM(CASE WHEN purchased = 0 THEN spend ELSE 0 END) AS nonbuyer_spend,
    SUM(CASE WHEN spend >= 100 AND purchased = 0 THEN 1 ELSE 0 END) AS heavy_nobuy,
    SUM(CASE WHEN spend >= 100 AND purchased = 0 AND cohort = 'Building' THEN 1 ELSE 0 END) AS heavy_nobuy_build,
    SUM(CASE WHEN spend > 200 AND purchased = 0 THEN 1 ELSE 0 END) AS over200_nobuy,
    SUM(CASE WHEN email_type = 'business' AND activated = 1 THEN 1 ELSE 0 END) AS biz_started,
    SUM(CASE WHEN email_type = 'business' AND purchased = 1 THEN 1 ELSE 0 END) AS biz_bought,
    SUM(CASE WHEN email_type = 'business' THEN 1 ELSE 0 END) AS biz_n,
    SUM(CASE WHEN email_type = 'personal' AND activated = 1 THEN 1 ELSE 0 END) AS per_started,
    SUM(CASE WHEN email_type = 'personal' AND purchased = 1 THEN 1 ELSE 0 END) AS per_bought,
    SUM(CASE WHEN email_type = 'personal' THEN 1 ELSE 0 END) AS per_n,
    SUM(CASE WHEN sql_flag = 1 AND purchased = 1 THEN 1 ELSE 0 END) AS sql_bought,
    SUM(CASE WHEN sql_flag = 1 AND purchased = 1 AND purchase_dt >= sql_dt THEN 1 ELSE 0 END) AS sql_buy_after_tag,
    MIN(CASE WHEN sql_flag = 1 AND purchased = 1 THEN purchase_dt END) AS sql_purchase_dt,
    MIN(CASE WHEN sql_flag = 1 AND purchased = 1 THEN sql_dt END) AS sql_tag_dt,
    SUM(CASE WHEN signup = (SELECT MAX(signup) FROM accounts) THEN 1 ELSE 0 END) AS signups_on_last_day,
    MAX(ABS(pattern_sum - spend)) AS pattern_gap,
    SUM(CASE WHEN first_call IS NOT NULL AND first_call < signup THEN 1 ELSE 0 END) AS call_before,
    COUNT(DISTINCT user_id) AS n_distinct
FROM accounts;
