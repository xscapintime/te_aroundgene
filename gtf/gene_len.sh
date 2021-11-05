#!/usr/bin/zsh


file=(up_gene.bed dn_gene.bed total_gene.bed)

for f in $file
do
	rn=`echo $f | sed "s/_gene.bed//g"`

	ln=`cat $f | awk 'OFS="\t" {SUM += $3-$2} END {print SUM}'`
       
	echo $rn $ln >> genegroup_len.txt
done

