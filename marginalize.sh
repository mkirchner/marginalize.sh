#!/bin/bash
#
# marginalize.sh
#
# Uses pdfinfo and ghostscript to add a generous margin for handwritten notes
# to research papers.
#
# Examples:
#
# * Add a margin of 1/3 of the page width on the right:
#
#    $ marginalize.sh -i input.pdf -o -output.pdf
#
# * Add a margin of 1/3 of the page width on the left:
#
#    $ marginalize.sh -i input.pdf -o -output.pdf -l
#
# * Add a custom margin of 144 pts on the right
#
#    $ marginalize.sh -i input.pdf -o -output.pdf -m 144
#
# Distributed under the MIT license, see LICENSE file.
# 

###############################
# Print help
###############################
usage() {
	echo -e "$(basename) $0 " \
	"\n\t-i <input file>     Filename of the input file" \
	"\n\t-o <output file>    Filename of the output file" \
	"\n\t[-m <margin_size>]  Margin size in pts (optional," \
	"\n\t                    defaults to 1/3 of page width)" \
	"\n\t[-l]                Put marging on the left"
}

###############################
# Main program
###############################

# parse command line
OPTS="i:o:m:l"
while getopts ${OPTS} opt; do
  case ${opt} in
    i)
      IN=${OPTARG}
      ;;
    o)
      OUT=${OPTARG}
      ;;
    m)
      MARGIN_SIZE=${OPTARG}
      ;;
    l)
      MARGIN_LEFT=true
      ;;
    :)
      echo "ERROR: Invalid argument: ${OPTARG} requires an argument" 1>&2
      usage
      exit 1
      ;;
    \?)
      echo "ERROR: Unknown option: ${OPTARG}" 1>&2
      usage
      exit 1
      ;;
  esac
done
shift $((OPTIND - 1))   
        
if [[ -z ${IN} || -z ${OUT} ]] ; then
  echo "ERROR: Require input and output arguments" 1>&2
  usage
  exit 1
fi

# get the size of the input file
read WIDTH HEIGHT <<<$(pdfinfo ${IN} | grep '^Page size' | awk '{print $3 " " $5;}')

# update the margin size info if necessary
if [[ -z ${MARGIN_SIZE} ]]; then
  MARGIN_SIZE=$((WIDTH / 3))
fi

# calculate the margin shift
MARGIN_SHIFT=0  # default: margin on right, zero shift
if [[ ${MARGIN_LEFT} ]]; then
  MARGIN_SHIFT=${MARGIN_SIZE}  # margin on left, shift by margin size
fi

# calculate the final width
WIDTH=$((WIDTH + MARGIN_SIZE))

# let ghostscript do its job
gs \
    -q \
    -sDEVICE=pdfwrite \
    -dBATCH \
    -dNOPAUSE \
    -sOutputFile=${OUT} \
    -dDEVICEWIDTHPOINTS=${WIDTH} \
    -dDEVICEHEIGHTPOINTS=${HEIGHT}\
    -dFIXEDMEDIA \
    -c "<< /Install { ${MARGIN_SHIFT} 0 translate } bind  >> setpagedevice" \
    -f ${IN}


