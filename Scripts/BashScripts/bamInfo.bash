#counts reads and average readlength from bamfile

samtools view $1 | awk 'BEGIN {tot=0; count=0};{tot=tot+length($10);count++} END {print tot" in "count" (ave="tot/count")"}'