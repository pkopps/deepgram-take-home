-- Credits used by the heaviest accounts, plus builder spend and total spend.
WITH ranked AS (
    SELECT spend, ROW_NUMBER() OVER (ORDER BY spend DESC, user_id) AS rn
    FROM accounts
)
SELECT
    (SELECT SUM(spend) FROM ranked WHERE rn <= 10) AS top_10,
    (SELECT SUM(spend) FROM ranked WHERE rn <= 50) AS top_50,
    (SELECT SUM(spend) FROM ranked WHERE rn <= 100) AS top_100,
    (SELECT SUM(spend) FROM accounts WHERE cohort = 'Building') AS builders,
    (SELECT SUM(spend) FROM accounts WHERE activated = 1) AS started,
    (SELECT SUM(spend) FROM accounts) AS total_spend;
