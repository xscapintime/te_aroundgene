#bedtools makewindows -g mm10.chrom.sizes -w 100 > genome_bin

for f in ../*_gene.bed
do
	rn=`basename $f | sed 's/.bed//g'`
	


	bedtools slop -i $f -g mm10.chrom.sizes -b 1000 | bedtools makewindows -b - -w 100 > ${rn}_updnstrm_genebody.bed
done

#rm genome_bin


