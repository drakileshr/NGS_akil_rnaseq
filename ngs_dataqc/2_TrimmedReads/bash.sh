#for i in `ls *_1_trimmed.gz|cut -d "_" -f1`
#do
#hisat2 -p 3 --rna-strandness \
#	RF --dta -x GRCh38.chr22.fasta 
#	-1 "$i"_1_trimmed.gz  -2 "$i"_2_trimmed.gz | samtools view -b | samtools sort -o ../#3_alignment/"$i"_1_trimmed.gz_sorted.bam
#done

hisat2 -p 3 --rna-strandness \
	RF --dta -x GRCh38.chr22.fasta 
	-1 HBR1_1_trimmed.gz  -2 HBR1_2_trimmed.gz | samtools view -b | samtools sort -o ../3_alignment/HBR1_1_trimmed.gz_sorted.bam

