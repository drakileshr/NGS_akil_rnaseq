#for i in `ls *_1_trimmed.gz|cut -d "_" -f1`
#do
#hisat2 -p 3 --rna-strandness RF --dta -x ./GRCh38.chr22.fasta -1 $i"_1_trimmed.gz"  -2 $i"_2_trimmed.gz" | samtools view -b | samtools sort -o "../../3_alignment/"$i"_sorted.bam"
#done

#hisat2 -p 3 --rna-strandness RF --dta -x ./GRCh38.chr22.fasta -1 HBR2_1_trimmed.gz  -2 HBR2_2_trimmed.gz | samtools view -b | samtools sort -o ../../3_alignment/HBR2_sorted.bam

#for i in `ls *_sorted.bam|cut -d "_" -f1`
#do
#sambamba sort "../../3_alignment/"$i".bam"
#done

#cd ../../3_alignment/

#featureCounts -p -T 4 -M -O -a GRCh38.chr22.gtf -o gene.expression.txt *.bam

#conda install -c bioconda stringtie

for i in `ls *_sorted.sorted.bam|cut -d "_" -f1`;do stringtie –G GRCh38.chr22.gtf –o $i"transcripts.gtf" $i"_sorted.sorted.bam";done

stringtie --merge -o merged.gtf -G GRCh38.chr22.gtf *transcripts.gtf

conda install -c bioconda pbmarkdup 
