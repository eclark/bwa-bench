#!/usr/bin/env bash

CMDS="/gsc/pkg/bio/bwa/bwa-0.5.5-64/bwa ./bwa"

REFSEQ=$1
OUTDIR=$2

shift 2

rm $OUTDIR/time.*
rm $OUTDIR/aln.*

i=1
for CMD in $CMDS; do
    n=1
    for F in $@; do
        outfile="$OUTDIR/time.$i.$n"
        alnfile="/tmp/$LSB_JOBID.tmpdir/aln.$i.$n"
        dest_alnfile="$OUTDIR/aln.$i.$n"

        echo $CMD >$outfile
        realcmd="$CMD aln $REFSEQ $F"
        /usr/bin/time -a -o $outfile $realcmd >$alnfile

        cp $alnfile $dest_alnfile
        rm -f $alnfile
        ((n++))
    done
    ((i++))
done
