-- People and buyers by email type and how they connected (none, console, API, or SDK).
SELECT
    email_type AS email,
    CASE integration_method
        WHEN 'none' THEN 'never started'
        WHEN 'console_only' THEN 'console only'
        WHEN 'direct_api' THEN 'direct API'
        WHEN 'sdk' THEN 'SDK'
    END AS how_used,
    COUNT(*) AS people,
    SUM(purchased) AS bought_any,
    SUM(bought_after_signup) AS bought_after,
    SUM(sql_flag) AS sql_n
FROM accounts
GROUP BY email_type, integration_method
ORDER BY CASE email_type WHEN 'business' THEN 1 ELSE 2 END,
    CASE integration_method
        WHEN 'none' THEN 1
        WHEN 'console_only' THEN 2
        WHEN 'direct_api' THEN 3
        ELSE 4
    END;
