# Deepgram $200 credits take-home

Self-serve signups get $200 in free API credits. This folder answers whether that offer is attracting builders or unused accounts, where the spend went, and what to change.

## Read this first

- Executive summary PDF: [docs/executive-summary.pdf](docs/executive-summary.pdf)
- Same summary in HTML: [docs/executive-summary.html](docs/executive-summary.html)

The summary is written in [executive-summary.qmd](executive-summary.qmd). It includes [\_setup.qmd](_setup.qmd), and Quarto writes the PDF and HTML into `docs/`.

## Layout

- [data/](data/) — the 10,000 signups
- [sql/](sql/) — the queries
- [docs/](docs/) — the rendered PDF and HTML
- [notes/](notes/) — the prompt, the hiring note, and the strange findings

## Data and prompt

- [data/deepgram_plg_cohort-analysttakehome.csv](data/deepgram_plg_cohort-analysttakehome.csv) — 10,000 signups
- [notes/assignment-prompt.txt](notes/assignment-prompt.txt)
- [notes/recruiter-email.txt](notes/recruiter-email.txt)

## How this was done

Worked in Cursor with the repo’s analysis rules (plain English, question headers, answer first, then evidence, appendix last). The longer note for the hiring conversation is [notes/how-this-was-done.md](notes/how-this-was-done.md).

Python in [\_setup.qmd](_setup.qmd) loads the CSV into SQLite, runs the queries in [sql/](sql/), and draws the chart. Pandas formats the results. Quarto renders HTML and PDF. `qa_summary.py` runs the same database.

No experiment ran here. Everyone in the file got the $200 grant, so this report does not claim the credits *caused* purchases.

## Render

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
export QUARTO_PYTHON="$(pwd)/.venv/bin/python"
quarto render
```
