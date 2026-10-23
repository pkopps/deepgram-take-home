-- Buyers and median buyer spend for all signups, post-signup buys, and business SDK accounts.
SELECT
    'All signups' AS slice,
    COUNT(*) AS people,
    SUM(purchased) AS bought,
    SUM(spend) AS used_spend,
    (
        SELECT AVG(spend) FROM (
            SELECT spend FROM accounts WHERE purchased = 1
            ORDER BY spend
            LIMIT 2 - ((SELECT SUM(purchased) FROM accounts) % 2)
            OFFSET ((SELECT SUM(purchased) FROM accounts) - 1) / 2
        )
    ) AS median_buyer_spend
FROM accounts
UNION ALL
SELECT
    'All signups, buy on/after signup only',
    COUNT(*),
    SUM(bought_after_signup),
    SUM(spend),
    (
        SELECT AVG(spend) FROM (
            SELECT spend FROM accounts WHERE bought_after_signup = 1
            ORDER BY spend
            LIMIT 2 - ((SELECT SUM(bought_after_signup) FROM accounts) % 2)
            OFFSET ((SELECT SUM(bought_after_signup) FROM accounts) - 1) / 2
        )
    )
FROM accounts
UNION ALL
SELECT
    'Business + SDK',
    COUNT(*),
    SUM(purchased),
    SUM(spend),
    (
        SELECT AVG(spend) FROM (
            SELECT spend FROM accounts
            WHERE email_type = 'business' AND integration_method = 'sdk' AND purchased = 1
            ORDER BY spend
            LIMIT 2 - ((SELECT COUNT(*) FROM accounts WHERE email_type = 'business' AND integration_method = 'sdk' AND purchased = 1) % 2)
            OFFSET ((SELECT COUNT(*) FROM accounts WHERE email_type = 'business' AND integration_method = 'sdk' AND purchased = 1) - 1) / 2
        )
    )
FROM accounts
WHERE email_type = 'business' AND integration_method = 'sdk';
