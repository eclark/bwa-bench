#!/usr/bin/env bash

MEM=10000
TMP=90000
CORES=4
QUEUE=long
REFERENCE=/opt/fscache/gscmnt/sata420/info/symlinks/reference_sequences/NCBI-human-build36/all_sequences.fa
INPUT="$HOME/bwa-bench-data/tiny.fa"
OUTPUTDIR=$HOME/bwa-bench-data/output
OUTFILE=$OUTPUTDIR/bwa-bench.out
ERRFILE=$OUTPUTDIR/bwa-bench.err

JOB="./bwabench.sh $REFERENCE $OUTPUTDIR $INPUT"
RESOURCE="select[type=LINUX64 && model!=Opteron250 && mem>$MEM tmp>$TMP] span[hosts=1] rusage[tmp=$TMP, mem=$MEM]"
PREEXEC="./preexec.sh $REFERENCE $OUTPUTDIR $INPUT"
RARGS="-E '$PREEXEC' -R '$RESOURCE' -M ${MEM}000 -n $CORES -q $QUEUE -o $OUTFILE -e $ERRFILE -z"

echo "bsub $RARGS $JOB"

bsub $RARGS $JOB

