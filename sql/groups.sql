-- People, credits used, credits used by buyers, buyers, and sales-qualified tags in each signup group.
SELECT
    cohort,
    COUNT(*) AS people,
    SUM(spend) AS spend,
    SUM(CASE WHEN purchased = 1 THEN spend ELSE 0 END) AS buyer_spend,
    SUM(purchased) AS bought,
    SUM(sql_flag) AS sql_n
FROM accounts
GROUP BY cohort
ORDER BY CASE cohort
    WHEN 'Never started' THEN 1
    WHEN 'Tried it' THEN 2
    ELSE 3
END;
