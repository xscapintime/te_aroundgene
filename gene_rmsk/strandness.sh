for f in *_rmsk.bed
do
	rn=`echo $f | sed "s/.bed//g"`

	cat $f | awk '($7 == $12)' > ${rn}_strand.bed
done	
