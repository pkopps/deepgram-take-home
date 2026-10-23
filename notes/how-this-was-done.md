# How this was done

This note is for the hiring conversation. It is not part of the board report. The report answers the VP's question. This file says how that report was built.

## The prompt

The VP asked three things: are the $200 credits attracting builders or freeloaders, where did the credit spend go, and what should we change. A later email said the first file a reviewer opens should be a PDF executive summary of findings and recommendations. Clear decisions mattered more than a dashboard or a production system.

The executive summary is the report. It states the decision, the actions, the chart, and the checks on the dates. The watchlist is the Intelligence Layer in miniature: the same counts, run again on the next signup file, with an action if a count moves.

## Cursor

The report was written in Cursor, in this repo, with Quarto. `executive-summary.qmd` is the summary. It includes `_setup.qmd`, which loads and labels the 10,000 rows. `quarto render` writes `docs/executive-summary.pdf` and `docs/executive-summary.html`.

The CSV in `data/` is loaded into SQLite. The cuts live in `sql/` and are rerun from there. Pandas still draws the charts and formats the tables. `qa_summary.py` uses the same database.

Cursor drafted and revised the text and the charts. Patrick set the questions, rejected wording that drifted, and decided what the summary was allowed to lead with. Examples: the first sentence stays "Answer: No, the $200 credits are not working." Dollar caveats and the expiration question stay behind that sentence. The 8,160 people who never called the API are described as not engaging, not as freeloaders.

## Rules in the repo

Five rules in `.cursor/rules/` apply to every edit. They exist so the report sounds like a colleague in a meeting, not like a model writing about its own writing.

- **Plain language.** Short sentences, a number, then what to do. No p-values, confidence intervals, regression words, or filler ("leverage," "robust insights," "delve"). If a count is too small to act on, say "too few people to trust."
- **No self-commentary.** Do not narrate the document. Cut "as mentioned above," "we will now," "in this section," and any sentence about the tone or the outline. The reader gets the finding.
- **Question, then answer.** Each section header starts with `Q:`. The next line is `A:` in one or two sentences. Charts and tables come after the answer. The Executive Summary and the Appendix are not questions, so they do not get a `Q:`.
- **Warnings in plain English.** If a gap could go either way, say so and do not treat it as a decision.
- **Appendix last.** Name a method only there, in everyday words. This report did not use a matching model. The appendix says why: everyone got $200, so this was not an experiment.

## What we refused to claim

Everyone in the file got $200. The report does not say the credits caused the 90 buys. It separates unused grant from credits actually used, and it says the file has no customer payments and no expiration date. The sales-qualified field is mostly dated before signup, so it is not the scorecard.
