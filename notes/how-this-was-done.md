# How I did this analysis

I downloaded a personal version of Cursor, installed Quarto package (my favorite for pdf or html based analysis and reporting).

Secondly I created a series of rules (some upfront, others mid-flight that I forgot about). Those rules are:

## How the report is written

- **Plain language.** Short sentences, a number, then what to do. No statistics jargon and no filler.
- **No redundancy.** If a later section repeats an earlier one, delete the later section.
- **No thinking out loud.** Do not narrate the document, the tone, or the outline.
- **Appendix.** Name a method only there, in everyday words. This report did not use one, so the appendix explains the funnel and that this was not an experiment.
- **Code comments.** One comment above each function, one comment at the top of each Quarto chunk, and one line at the top of each SQL file saying what the query returns.

Note: I have others but they pertain here.

The assignment says if you use AI, say how. I used Cursor, the IDE, through chat prompting. The rules above are what that chat had to follow. Some were set up front, and some mid-flight.

The initial plan was to load the CSV into SQLite, put the cuts in SQL, and write one executive summary in Quarto for a VP. Answer first, then insights and what to do next, then the funnel on page 2, then an appendix for the date checks and QA. That is the plan I executed.

I estimate chat prompting accounts for about 60-70% of the lines created and edited. I do not use AI for QA. It can assist, but a human needs to be the driver there.

I added the CSV data to a SQLite DB to closer mimic a production environment. If you want a semantic layer, the join, business, etc. logic should be written in SQL I would recommend.

From here I begin the analysis. The audience is VP, reporting back to the board. That means straight answer, he or she can understand, without reading or digging for it.

That said, Executive Summary has an eye drawing box that with the question and the answer (in the box).

From there, there are additional insights, and then recommendations on what to do next.

Moving on to page 2, there are visuals and funnel-related information present. I talk about limitation with that data in terms of spend amounts, as well as sales team role here.

Finally I added an Appendix section with some callouts about the data and QA thresholds.

## What I did not do

I did not create a semantic layer. Unless I misread the prompt I don't believe I was supposed to.
