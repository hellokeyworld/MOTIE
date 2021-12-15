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

output=$DIR/optiType/

#####OPTITYPE HLAtype####
echo '###Step 1 HLAtyping'

python $OptitypeDIR/OptiTypePipeline.py \
-i $RID_1 $RID_2 \
--rna \
-v -b 0.009 -e 4 \
-c $OptitypeDIR/config.ini \
-o $output



if [ ! -d $output/parse ]
then
    mkdir -p $output/parse
fi

output_parse=$output/parse


next_DIR=` ls $output | egrep -v parse | tail -n1 `


if [ -e $output/$next_DIR/$next_DIR'_result.tsv' ]
then
        A=`cat $output/$next_DIR/$next_DIR'_result.tsv' | head -n2 | tail -n1 | awk '{print $2,$3}' | sed -e 's/ /,/'`
        B=`cat $output/$next_DIR/$next_DIR'_result.tsv' | head -n2 | tail -n1 | awk '{print $4,$5}' | sed -e 's/ /,/'`
        C=`cat $output/$next_DIR/$next_DIR'_result.tsv' | head -n2 | tail -n1 | awk '{print $6,$7}' | sed -e 's/ /,/'`
        echo -e 'HLA-A\tHLA-B\tHLA-C' > $output_parse/$sample'.hla.txt'
        echo -e $A'\t'$B'\t'$C >> $output_parse/$sample'.hla.txt'
fi



######### Neopepsee Input#########

HLAINFO=$output_parse/$sample'.hla.txt'

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




