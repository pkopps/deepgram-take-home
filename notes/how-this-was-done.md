# How I did this analysis

I downloaded a personal version of Cursor, installed Quatro package (my favorite for pdf or html based analysis).

Secondly I created a series of rules (some upfront, other mid-flight that I forgot about). Those rules are:

## How the report is written

- **Plain language.** Short sentences, a number, then what to do. No statistics jargon and no filler.
- **No redundancy.** If a later section repeats an earlier one, delete the later section.
- **No thinking out loud.** Do not narrate the document, the tone, or the outline.
- **Appendix.** Name a method only there, in everyday words. This report did not use one, so the appendix explains the funnel and that this was not an experiment.

## How the code is commented

- **Code comments.** One comment above each function, one comment at the top of each Quarto chunk, and one line at the top of each SQL file saying what the query returns.

Note: I have other but they pertain here.

I added the CSV data to a SQLite DB to closer mimic a production environment. If you want a semantic layer, the join, business, etc. logic should be written in SQL I would recommend.

From here I begin the analysis. The audience is VP, reporting back to the board. That means straight answer, he or she can understand, without reading or digging for it.

That said, Executive Summary has an eye drawing box that with the question and the answer (in the box).

From there, there are additional insights, and then recommendations on what to do next.

Moving on to page 2, their are visuals and funnel related information present. I talk about limitation with that data in terms of spend amounts, as well as sales team role here.

Finally I added an Appendix section with some callouts about the data and QA thresholds.

## What I did not do

I did not create a semantic layer. Unless I misread the prompt I don't believe I was supposed to.
