-- Headcount at each step from signup to a sales-qualified tag after signup.
SELECT 'Signed up' AS step, COUNT(*) AS people FROM accounts
UNION ALL
SELECT 'Made an API call', SUM(activated) FROM accounts
UNION ALL
SELECT 'Look like builders', SUM(CASE WHEN cohort = 'Building' THEN 1 ELSE 0 END) FROM accounts
UNION ALL
SELECT 'Bought', SUM(purchased) FROM accounts
UNION ALL
SELECT 'Tagged sales-qualified after signup', SUM(
    CASE WHEN sql_flag = 1 AND sql_dt IS NOT NULL AND sql_dt >= signup THEN 1 ELSE 0 END
) FROM accounts;
