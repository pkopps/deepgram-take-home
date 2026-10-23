-- How soon people call the API and buy, including the median days from signup.
SELECT
    SUM(CASE WHEN activated = 1 AND julianday(first_call) - julianday(signup) = 0 THEN 1 ELSE 0 END) AS start_same_day,
    SUM(CASE WHEN activated = 1 AND julianday(first_call) - julianday(signup) > 7 THEN 1 ELSE 0 END) AS start_after_7,
    SUM(activated) AS starters,
    SUM(CASE WHEN bought_after_signup = 1 AND julianday(purchase_dt) - julianday(signup) <= 7 THEN 1 ELSE 0 END) AS buy_within_7,
    SUM(CASE WHEN bought_after_signup = 1 AND julianday(purchase_dt) - julianday(signup) <= 30 THEN 1 ELSE 0 END) AS buy_within_30,
    SUM(bought_after_signup) AS buyers_after,
    (
        SELECT AVG(lag_days) FROM (
            SELECT julianday(first_call) - julianday(signup) AS lag_days
            FROM accounts
            WHERE activated = 1
            ORDER BY lag_days
            LIMIT 2 - ((SELECT SUM(activated) FROM accounts) % 2)
            OFFSET ((SELECT SUM(activated) FROM accounts) - 1) / 2
        )
    ) AS median_start_days,
    (
        SELECT AVG(lag_days) FROM (
            SELECT julianday(purchase_dt) - julianday(signup) AS lag_days
            FROM accounts
            WHERE bought_after_signup = 1
            ORDER BY lag_days
            LIMIT 2 - ((SELECT SUM(bought_after_signup) FROM accounts) % 2)
            OFFSET ((SELECT SUM(bought_after_signup) FROM accounts) - 1) / 2
        )
    ) AS median_buy_days
FROM accounts;
