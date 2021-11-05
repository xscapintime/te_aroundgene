#!/usr/bin/zsh



for f in ../gtf/*.bed
do

	if ! [[ $f =~ "ensembl_gtf" ]]
	then
		bn=`basename $f`
        	rn=`echo $bn | sed 's/.bed//g'`

		if [[ ! -f ${rn}_rmsk.bed ]]; then

			echo $bn "===================>\n""bedtools intersecting...\nOriginal entries"

			bedtools intersect -a ../rmsk_fin.bed -b ${f} -wo > ${rn}_rmsk.bed
		fi
	fi
done

