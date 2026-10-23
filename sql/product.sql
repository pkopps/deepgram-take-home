-- Credits used and buyers for each primary product, among accounts that called the API.
SELECT
    primary_product,
    COUNT(*) AS people,
    SUM(spend) AS spend,
    SUM(purchased) AS bought
FROM accounts
WHERE activated = 1
GROUP BY primary_product
ORDER BY spend DESC;
