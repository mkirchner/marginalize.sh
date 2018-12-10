marginalize.sh - Add margins to research papers
===============================================

I like to take notes while reading research papers but reseach papers don't
have reasonably sized margins. That's annoying since it disconnects the notes
from the original text. Hence, enter `marginalize.sh`.

Getting started
---------------

### Installation

1. Satisfy requirements: 
  * `pdfinfo` (e.g. via `brew install xpdf` on MacOS)
  * `gs` (e.g. via `brew install ghostscript` on MacOS)
2. Clone the repo or download the shell script
3. Link or copy to location that's in your `$PATH`

### Running it

It's quite straightforward:

        $ marginalize.sh -i gatys_2015_style.pdf \
                         -o gatys_2015_style-with-margin.pdf

And voila: space for notes.

### Comments

* Margin size must be specified in points (there are 72 points in an inch). If
  the user does not specify a margin size, the margin is set to `1/3 *
  pagewidth`, roughly mimicking the design of the [Tufte handout][tufte]

[tufte]: https://ctan.org/pkg/tufte-latex?lang=en

