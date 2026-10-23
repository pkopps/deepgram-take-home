# How I did this analysis: where I used AI, and where I did not

The assignment says if you use AI, say how. I used Cursor, the IDE, through chat prompting. I estimate chat prompting accounts for about 60-70% of the lines created and edited.

## Where I did not use AI

I do not use AI for QA. It can assist, but a human needs to be the driver there.

I added an Appendix section with some callouts about the data and QA thresholds.

## Where I used AI

I downloaded a personal version of Cursor, installed Quarto package (my go to for pdf or html based analysis and reporting).

Secondly I created a series of rules (some upfront, others mid-flight that I forgot about). Those rules are what that chat had to follow.

### How the report is written

- **Plain language.** Short sentences, a number, then what to do. No statistics jargon and no filler.
- **No redundancy.** If a later section repeats an earlier one, delete the later section.
- **No thinking out loud.** Do not narrate the document, the tone, or the outline.
- **Appendix.** Name a method only there, in everyday words. This report did not use one, so the appendix explains the funnel and that this was not an experiment.
- **Code comments.** One comment above each function, one comment at the top of each Quarto chunk, and one line at the top of each SQL file saying what the query returns.

Note: I have others but they don't pertain here.

The initial plan was to load the CSV into SQLite, put the cuts in SQL, and write one executive summary in Quarto for a VP. Answer first, then insights and what to do next, then the funnel on page 2, then an appendix for the date checks and QA. That is the plan I executed.

I added the CSV data to a SQLite DB to closer mimic a production environment. If you want a semantic layer, the join, business, etc. logic should be written in SQL I would recommend.

## What I did not do

I did not create a semantic layer. Unless I misread the prompt I don't believe I was supposed to.
