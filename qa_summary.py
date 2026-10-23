"""Summarize the signup file from the queries in sql/.

Run from the repo root:

    .venv/bin/python qa_summary.py
"""

import db


# Print a heading and a rule under it.
def section(title):
    print()
    print(title)
    print("-" * len(title))


# Load the signup file and print row counts, value counts, and which QA checks pass or fail.
def main():
    db.connect()
    totals = db.q("totals").iloc[0]
    checks = db.q("qa_checks").iloc[0]
    profile = db.q("profile_columns")

    section("File")
    print(f"Path: {db.DATA.name}")
    print(f"Rows: {int(totals.n):,}")
    print(f"Columns: {len(profile)}")
    print(f"Signup dates: {totals.first_signup} to {totals.last_signup}")

    section("Nulls and unique values")
    shown = profile.copy()
    shown["filled"] = int(totals.n) - shown["blanks"]
    shown["unique_including_blank"] = shown["unique_values"] + (shown["blanks"] > 0).astype(int)
    print(shown.to_string(index=False))

    section("Duplicates")
    print(f"Duplicate user_id values: {int(totals.n - checks.distinct_users)}")
    print(f"Fully duplicate rows: {int(checks.duplicate_rows)}")

    section("Value counts (short columns)")
    counts = db.q("value_counts")
    for column, rows in counts.groupby("column_name", sort=False):
        print()
        print(column)
        print(rows.set_index("value")["people"].to_string())

    section("Numeric summary")
    print(db.q("numeric_summary").round(2).to_string(index=False))
    print("Signups by month:")
    print(db.q("signups_by_month").to_string(index=False))

    passed = [
        ("Row count is 10,000", int(checks.row_count) == 10000, f"{int(checks.row_count):,} rows"),
        ("Every user_id is unique", int(checks.distinct_users) == int(checks.row_count), f"{int(checks.distinct_users):,} ids"),
        ("No duplicate rows", int(checks.duplicate_rows) == 0, f"{int(checks.duplicate_rows)} duplicate rows"),
        (
            "No negative spend or negative days active",
            checks.min_spend >= 0 and checks.min_days >= 0,
            f"min spend {checks.min_spend:.2f}, min days {checks.min_days:.0f}",
        ),
        ("Spend > $0 always has a first API call date", int(checks.spend_without_call) == 0, f"{int(checks.spend_without_call)} rows"),
        ("First API call always has spend > $0 and days active > 0", int(checks.call_without_spend) == 0, f"{int(checks.call_without_spend)} rows"),
        ("Purchased flag matches purchase_date", int(checks.purch_flag_mismatch) == 0, f"{int(checks.purch_flag_mismatch)} mismatches"),
        ("Sales-qualified flag matches sql_date", int(checks.sql_flag_mismatch) == 0, f"{int(checks.sql_flag_mismatch)} mismatches"),
        (
            "integration_method is none only when there is no API call",
            int(checks.none_with_call) == 0 and int(checks.method_without_call) == 0,
            f"{int(checks.none_with_call)} none-with-call, {int(checks.method_without_call)} method-without-call",
        ),
        (
            "Primary product is filled only when they used the product",
            int(checks.primary_missing) == 0 and int(checks.primary_when_idle) == 0,
            f"{int(checks.primary_missing)} missing, {int(checks.primary_when_idle)} filled with no call",
        ),
        ("Monthly spend list adds up to total spend", checks.max_pattern_gap <= 0.02, f"max gap ${checks.max_pattern_gap:.4f}"),
        ("Primary product is always in products_used", int(checks.primary_not_in_list) == 0, f"{int(checks.primary_not_in_list)} mismatches"),
        ("No API call dated before signup", int(checks.call_before_signup) == 0, f"{int(checks.call_before_signup)} rows"),
    ]
    failed = [
        ("Purchase dated before signup", int(checks.purch_before)),
        ("Bought but never made an API call", int(checks.buy_no_call)),
        ("Sales-qualified dated before signup", int(checks.sql_before)),
        ("Sales-qualified but did not buy", int(checks.sql_no_buy)),
        ("Spend above the $200 grant", int(checks.over_grant)),
        ("First API call dated after purchase", int(checks.call_after_buy)),
        ("March 2026 signup month looks incomplete", int(checks.march_signups)),
    ]

    section("QA checks that should pass")
    for name, ok, detail in passed:
        print(f"{'PASS' if ok else 'FAIL'}  {name} ({detail})")

    section("QA issues that change how to read conversion")
    for name, count in failed:
        print(f"{count:>5}  {name}")
    print(f"Max spend in file: ${checks.max_spend:.2f}")


if __name__ == "__main__":
    main()
