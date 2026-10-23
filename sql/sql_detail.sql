-- Sales-qualified accounts by when they were tagged, which group they are in, and whether they bought.
SELECT
    CASE
        WHEN sql_dt IS NULL THEN 'Missing date'
        WHEN sql_dt < signup THEN 'Before signup'
        ELSE 'On or after signup'
    END AS when_tagged,
    cohort,
    purchased,
    COUNT(*) AS people
FROM accounts
WHERE sql_flag = 1
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;
