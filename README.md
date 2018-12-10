marginalize.sh - Add margins to research papers
===============================================

Reading research papers on the iPad (using your favorite PDF app) has become
pretty awesome, in particular with the ability to use the Apple Pencil to add
notes.

The only drawback is that research papers generally do not have reasonably
sized margins for that kind of use case. That is a quite unfortunate situation
since it either limits note-taking or disconnects the notes from the original
text.

`marginalize.sh` is a simple shell script that allows you to add the margin you
need for your notes.

![Before and after](https://github.com/mkirchner/marginalize.sh/blob/master/doc/before_after.png)

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

        $ marginalize.sh -i girshick_15_fast.pdf \
                         -o girshick_15_fast-notes.pdf

And voila: space for notes.


Comments
--------

### Margins

Margin size must be specified in points (there are 72 points in an inch). If
the user does not specify a margin size, the margin is set to `1/3 *
pagewidth`, roughly mimicking the design of the [Tufte handout][tufte].

### Lefties!

If you're left-handed, you might want to try with the margin on the left:

        $ marginalize.sh -i girshick_15_fast.pdf \
                         -o girshick_15_fast-notes.pdf \
                         -l

### Credits

Originally based on [HullCityFan852][hcf]'s [superuser post][su_post] about
adding gutter to PDFs.

[hcf]: https://superuser.com/users/388203/hullcityfan852
[su_post]: https://superuser.com/questions/904332/add-gutter-binding-margin-to-existing-pdf-file
[tufte]: https://ctan.org/pkg/tufte-latex?lang=en
