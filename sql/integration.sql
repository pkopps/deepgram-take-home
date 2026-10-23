-- Median spend, median days active, buyers, and credits used for each way of connecting, among accounts that called the API.
WITH ranked AS (
    SELECT
        integration_method,
        spend,
        days,
        purchased,
        ROW_NUMBER() OVER (PARTITION BY integration_method ORDER BY spend) AS spend_rn,
        ROW_NUMBER() OVER (PARTITION BY integration_method ORDER BY days) AS days_rn,
        COUNT(*) OVER (PARTITION BY integration_method) AS n
    FROM accounts
    WHERE activated = 1
)
SELECT
    integration_method AS method,
    MAX(n) AS people,
    AVG(CASE
        WHEN n % 2 = 1 AND spend_rn = (n + 1) / 2 THEN spend
        WHEN n % 2 = 0 AND spend_rn IN (n / 2, n / 2 + 1) THEN spend
    END) AS median_spend,
    AVG(CASE
        WHEN n % 2 = 1 AND days_rn = (n + 1) / 2 THEN days
        WHEN n % 2 = 0 AND days_rn IN (n / 2, n / 2 + 1) THEN days
    END) AS median_days,
    SUM(purchased) AS bought,
    SUM(spend) AS spend
FROM ranked
GROUP BY integration_method
ORDER BY CASE integration_method
    WHEN 'console_only' THEN 1
    WHEN 'direct_api' THEN 2
    ELSE 3
END;
