-- Split the $200 grant into granted, used, unused, and who used it.
SELECT 'Granted ($200 × 10,000 signups)' AS bucket, COUNT(*) * 200.0 AS amount FROM accounts
UNION ALL
SELECT 'Used (sum of spend in the file)', SUM(spend) FROM accounts
UNION ALL
SELECT 'Unused vs the $200 grant', SUM(CASE WHEN spend < 200 THEN 200 - spend ELSE 0 END) FROM accounts
UNION ALL
SELECT 'Used by never-started accounts', SUM(CASE WHEN cohort = 'Never started' THEN spend ELSE 0 END) FROM accounts
UNION ALL
SELECT 'Used by tried-it accounts', SUM(CASE WHEN cohort = 'Tried it' THEN spend ELSE 0 END) FROM accounts
UNION ALL
SELECT 'Used by building accounts', SUM(CASE WHEN cohort = 'Building' THEN spend ELSE 0 END) FROM accounts
UNION ALL
SELECT 'Used above $200 (not explained by the free grant)', SUM(CASE WHEN spend > 200 THEN spend - 200 ELSE 0 END) FROM accounts;
