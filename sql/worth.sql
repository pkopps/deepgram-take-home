-- Buyers inside the slices the sales call cares about: business builders, personal builders, console, and never started.
SELECT 'Business email + building' AS slice, COUNT(*) AS people, SUM(purchased) AS bought
FROM accounts
WHERE cohort = 'Building' AND email_type = 'business'
UNION ALL
SELECT 'Personal email + building', COUNT(*), SUM(purchased)
FROM accounts
WHERE cohort = 'Building' AND email_type = 'personal'
UNION ALL
SELECT 'Console only (any email)', COUNT(*), SUM(purchased)
FROM accounts
WHERE integration_method = 'console_only'
UNION ALL
SELECT 'Never started (any email)', COUNT(*), SUM(purchased)
FROM accounts
WHERE cohort = 'Never started';
