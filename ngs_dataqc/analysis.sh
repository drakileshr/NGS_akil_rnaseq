#!/bin/bash
mkdir 2_TrimmedReads
# first cycle
fastp 	-i ../dataHBR/HBR1_1*.gz \
	-I ../dataHBR/HBR1_2*.gz \
	-o ./2_TrimmedReads/HBR1_1_trimmed.gz \
	-O ./2_TrimmedReads/HBR1_2_trimmed.gz 
	-w 3 -g -x \
	-h HBR1_1fastp.html \
	-j HBR1_2fastp.json

#second cycle
fastp 	-i ../dataHBR/HBR2_1*.gz \
	-I ../dataHBR/HBR2_2*.gz \
	-o ./2_TrimmedReads/HBR2_1_trimmed.gz \
	-O ./2_TrimmedReads/HBR2_2_trimmed.gz \
	-w 3 -g -x \
	-h HBR2_1fastp.html \
	-j HBR2_2fastp.json

#third cycle
fastp 	-i ../dataHBR/HBR3_1*.gz \
	-I ../dataHBR/HBR3_2*.gz \
	-o ./2_TrimmedReads/HBR3_1_trimmed.gz \
	-O ./2_TrimmedReads/HBR3_2_trimmed.gz \
	-w 3 -g -x \
	-h HBR3_1fastp.html \
	-j HBR3_2fastp.json

# first cycle
fastp 	-i ../dataHBR/UHR1_1*.gz \
	-I ../dataHBR/UHR1_2*.gz \
	-o ./2_TrimmedReads/UHR1_1_trimmed.gz \
	-O ./2_TrimmedReads/UHR1_2_trimmed.gz 
	-w 3 -g -x \
	-h UHR1_1fastp.html \
	-j UHR1_2fastp.json

#second cycle
fastp 	-i ../dataHBR/UHR2_1*.gz \
	-I ../dataHBR/UHR2_2*.gz \
	-o ./2_TrimmedReads/UHR2_1_trimmed.gz \
	-O ./2_TrimmedReads/UHR2_2_trimmed.gz \
	-w 3 -g -x \
	-h UHR2_1fastp.html \
	-j UHR2_2fastp.json

#third cycle
fastp 	-i ../dataHBR/UHR3_1*.gz \
	-I ../dataHBR/UHR3_2*.gz \
	-o ./2_TrimmedReads/UHR3_1_trimmed.gz \
	-O ./2_TrimmedReads/UHR3_2_trimmed.gz \
	-w 3 -g -x \
	-h UHR3_1fastp.html \
	-j UHR3_2fastp.json
	
#loop
#mkdir 2_TrimmedReads/loop/
#cp ../dataHBR/* ./
#for i in `ls *_1.fastq.gz|cut -d "_" -f1`
#	do
#		echo "Processing $i ..."
#run fastp commands
#fastp 	-i $i"_1.fastq.gz" \
#@	-I $i"_2.fastq.gz" \
#	-o "../2_TrimmedReads/loop/"$i"_2_trimmed.gz" \
#	-O "./2_TrimmedReads/loop/"$i"HBR2_2_trimmed.gz" \
#	-w 3 -g -x \
#	-h "../2_TrimmedReads/loop/"$i"fastp.html" \
#	-j "../2_TrimmedReads/loop/"$i"HBR2_fastp.json"
#done

#DIFFERENT ENV GENOMES
#Index
hisat2-build -t 2 GRCh38.chr22.fasta  GRCh38.chr22.fasta 

#Alignment
hisat2 -p 3 --rna-strandness RF --dta -x GRCh38.chr22.fasta -1 ../ngs_dataqc/2_TrimmedReads/HBR1_1_trimmed.gz  -2 ../ngs_dataqc/2_TrimmedReads/HBR1_2_trimmed.gz  -S HBR1_1.sam


conda create -p ./samtools-env -c bioconda samtools 
#SAMTOOLS
hisat2 -p 3 --rna-strandness RF --dta -x GRCh38.chr22.fasta -1 ../ngs_dataqc/2_TrimmedReads/HBR1_1_trimmed.gz  -2 ../ngs_dataqc/2_TrimmedReads/HBR1_2_trimmed.gz | samtools view -b | samtools sort -o ../3_alignment/HBR1_sorted.bam

cd ..ngs_dataqc/2TrimmedReads/
for i in 'ls *_1_trimmed.gz'
do
hisat2 -p 3 --rna-strandness RF --dta -x GRCh38.chr22.fasta -1 $i"1_trimmed.gz"  -2 $i"_2_trimmed.gz" | samtools view -b | samtools sort -o "../3_alignment/"$i"_sorted.bam"
done
