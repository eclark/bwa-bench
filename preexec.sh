#!/usr/bin/env bash

USAGE="Usage: $0 <ref.fa> <outputdir> <file1> .. <fileN>"

if [ $# -lt 3 ]; then
    echo "$USAGE"
    exit 1
fi

REFSEQ=$1
OUTDIR=$2

shift 2

#echo $@

if [ ! -r $REFSEQ ]; then
    echo "Unreadable refseq: $REFSEQ"
    exit 2
fi

if [ ! -r "$REFSEQ.bwt" ]; then
    echo "Unreadable refseq: $REFSEQ.bwt"
    exit 2
fi

if [ ! -r "$REFSEQ.rbwt" ]; then
    echo "Unreadable refseq: $REFSEQ.rbwt"
    exit 2
fi

if [ ! -d $OUTDIR ]; then
    echo "Outdir is not a directory: $OUTDIR"
    exit 2
fi

for F in $@; do
    if [ ! -r $F ]; then
        echo "Unreadable file: $F"
        exit 2
    fi
done

