####
# bedtools slop -s doesn't work, same result as no '-s'
# bedtools flank -s returns blank output


#for f in ../*_gene.bed
for f in *_flank.bed
do
	rn=`basename $f | cut -d "_" -f 1,2`
	
	# need consider strandness
	# bedtools slop -i $f -g mm10.chrom.sizes -l 1000 -r 0 -s | bedtools subtract -a - -b $f -s | bedtools makewindows -b - -w 100 > ${rn}_upstrm.bed

	## bedtools flank
	#bedtools flank -i $f -g mm10.chrom.sizes -l 1000 -r 0 -s | bedtools makewindows -b - -w 100 > ${rn}_upstrm.bed


	## flanked with python
	bedtools makewindows -b $f -w 100 > ${rn}_upstrm.bed

done

#rm genome_bin


