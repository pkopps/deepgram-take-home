-- Signups, starters, buyers, and credits used for each signup month.
SELECT
    signup_month AS month,
    COUNT(*) AS signups,
    SUM(activated) AS started,
    SUM(purchased) AS bought,
    SUM(spend) AS spend
FROM accounts
GROUP BY signup_month
ORDER BY signup_month;
