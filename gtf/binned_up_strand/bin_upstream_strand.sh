#bedtools makewindows -g mm10.chrom.sizes -w 100 > genome_bin


for f in ../*_gene.bed
do
	rn=`basename $f | sed 's/.bed//g'`
	
	# need consider strandness
	bedtools slop -i $f -g mm10.chrom.sizes -l 1000 -r 0 -s | bedtools subtract -a - -b $f | bedtools makewindows -b - -w 100 > ${rn}_upstrm.bed
done

#rm genome_bin


