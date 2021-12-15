#!/bin/bash
#$ -S /bin/bash
#$ -cwd
OptitypeDIR=$1 ##/opt/Yonsei/OptiType/1.3.2/
RID_1=$2
RID_2=$3
DIR=$4
NeopepseeDIR=$5 ##/opt/Yonsei/Neopepsee/3.0.1/
sample=$6
VCF=$7
HLA=$8


######### Neopepsee Input#########

echo '###Step 1 Data Check'

HLAINFO=$HLA

uRID_1=`echo $RID_1 | sed 's/fastq.gz/fastq/' `
uRID_2=`echo $RID_2 | sed 's/fastq.gz/fastq/' `


echo $uRID_1
echo $uRID_2

if [ ! -f $uRID_1 ]
then
	gzip -dc $RID_1 > $uRID_1
	gzip -dc $RID_2 > $uRID_2
fi


if [ ! -d $DIR/Neopepsee/$sample ]
then
        mkdir -p $DIR/Neopepsee/$sample/
fi

echo $HLAINFO


######### Neopepsee ########### 


echo '###Step 2 Call Neoantigen'

java -jar $NeopepseeDIR/neopepsee-3.0.1.jar \
-r $NeopepseeDIR/database/ref/hg19/knownGene_v3.fasta \
-1 $uRID_1 \
-2 $uRID_2 \
-e 0 \
-m $HLAINFO \
-v $VCF \
-d $DIR/Neopepsee/$sample \
-n 9




