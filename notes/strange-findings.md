# Strange findings

The order we expected: signup, the $200 lands immediately, the account uses $0 to $200, then they pay or they do not.

The file has no grant date. We are treating the grant as immediate on a successful signup.

## Q: Does Deepgram's site describe that order?

**A:** The first half, yes. A purchase is not the last step. You can pay before you call the API, and you can call the API and never pay.

The signup pages say a new account gets $200 and does not need a card. [Console signup](https://console.deepgram.com/signup) says "Get $200 in credit absolutely free" and "No credit card needed." The [pricing page](https://deepgram.com/pricing) says every new account receives $200. The [project docs](https://developers.deepgram.com/guides/deep-dives/managing-projects) say signup creates a project and the promotional credit is attached to that first project.

Paying is a separate choice, and it can happen at any time:

- Pay As You Go can auto-load more credits. The default on the pricing page is a $100 reload when the balance falls below $10.
- A Growth plan is an upfront purchase, starting at $4,000 a year. That does not require the $200 to be used up.
- You can add a card and buy credits without making an API call.

These pages were read on 21 Oct 2026. The signups in the file are Sep 2025 through 1 Mar 2026. The site describes the product now, not a rule we can prove was in force for every row.

## Q: Do API calls follow signup?

**A:** Yes. Zero accounts have a first API call before signup. Use of the product lines up with the order we expected.

## Q: Can a purchase happen before the $200 exists?

**A:** In this file, yes, 11 times. The data dictionary says `purchase_date` can precede signup, so these rows are allowed. They are still not the credit turning a signup into a customer.

All 11 are business-email accounts. The purchase is 3 to 29 days before signup. The middle gap is 16 days. Nine of them called the API afterward. Eight became builders. Two never used the product.

| When they paid | People |
| --- | --- |
| Before signup | 11 |
| Same day as signup | 29 |
| After signup | 50 |

A prior contract could explain a pay date before this account existed. Deepgram sells Growth and Enterprise through the sales team, separate from the self-serve $200. Someone who already paid could then open a console account and receive a new $200. The gaps here are short, and every one is a business email, which fits "paid, then created this account" better than a date scrambled across years.

This file cannot show that older contract. Leave these 11 out of the success count.

## Q: Do the other buyers pay after they use the $200?

**A:** Most of them pay early, with credits still left. Of the 79 purchases on or after signup, 29 are the same day, 48 are within 7 days, and the middle wait is 4 days. Among the 48 who paid within 7 days, the middle spend is $146. Five of them had used less than $25.

The middle spend among all 90 buyers is $102. Only 25 of the 90 ever went past $200.

One account paid on or after signup and never called the API. Together with the two pre-signup buyers who never called, that is 3 buyers with no API call. The site allows a payment with no API call. It does not match "use the credits, then pay."

## Q: Why does spend go above $200?

**A:** 62 accounts spent more than $200. The dollars above $200 add up to $4,987. The highest spend is $400. 25 of the 62 bought. 37 did not.

The column is defined as total free credits consumed, and the free grant is $200. A free-credit column should stop at $200. The public product also should not let usage continue past an empty balance unless a card is on file. The pricing page says a request comes back with an error once credits are gone and there is no card.

So 37 accounts used more than the free grant and are not marked as paying customers. That breaks both the column label and the public billing rule. The 25 who did pay can be read as paid credits mixed into a column labeled free credits. We cannot tell those two stories apart from this file.

## Q: What is the sales-qualified column?

**A:** `became_sql` means "Tagged as Sales Qualified Lead?" `sql_date` is the date of that tag. The date is blank when the account was never tagged. The prompt says the date can fall before signup. The prompt does not say what earned the tag. In sales, a sales-qualified lead is an account the sales team has accepted as worth a conversation.

The dates here are not the story of this signup. They run much further out of range than the purchase dates.

20 accounts are tagged. 16 tags are before signup. The middle gap is 217 days, about 7 months. The earliest tag is 26 Nov 2024, before any signup in this file. Nine of the 16 are more than 6 months before signup. One tag is 28 Mar 2026, and the last signup in the file is 1 Mar 2026. 19 of the 20 never bought.

The one who bought was tagged after both signup and the purchase: signup 23 Dec 2025, purchase 19 Jan 2026, tag 12 Feb 2026.

A sales tag on an older lead could land on a later self-serve account. A tag dated before the extract starts, and another dated after the extract ends, looks like a field joined in from somewhere else. Do not use this flag to judge the credits.

## Q: Do the free credits expire?

**A:** The public site disagrees with itself, and this file has no expiration date.

The pricing page says the $200 lasts until it is used, and the Pay As You Go box says no expiration. The project docs say free promotional credits expire one year from signup. Purchased credits, on that same docs page, do not expire.

If the one-year rule is the real one, the unused grant does not sit forever. If the pricing page is the real one, it does. These 10,000 rows cannot settle it.

## Q: Why does March have 45 signups?

**A:** The file stops on 1 Mar 2026. All 45 March signups are that day. Other months have about 1,500 to 1,750. The first API call also never falls after 1 Mar 2026. March is the edge of the extract, not a collapse in signups.

# Appendix

**Date order.** We compared `signup_date` with `purchase_date`, `first_api_call_date`, and `sql_date`. A date is "before signup" when it falls on an earlier calendar day. Same day means the dates match. There is no column for when the $200 was posted. We treat that moment as the signup, because the prompt says every self-serve signup gets $200 and the current signup page grants it with the account.

**Small counts.** 90 purchases and 20 sales-qualified tags are small. The date gaps above are large enough to see on those small groups. A slice of a few people inside them is not.

**This was not an experiment.** Everyone in the file got $200. Nothing here says the credit caused a purchase. The public site was checked on 21 Oct 2026, after these signups, so a page can explain what the product allows now and still fail to prove what a row from 2025 meant.
