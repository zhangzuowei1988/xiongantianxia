
QQID=$(echo "obase=16;100424468"|bc)
length=$(echo "$QQID" | awk '{print length($0)}')

while [ $length -lt 8 ]
do
   QQID="0"${QQID}
   length=$[$length+1]
   
done

echo $QQID

#
#
#if [ $length -lt 8 ]
#then
#num=$[8-$length]
#echo $num
#
#fi


#echo $QQID
#
# QQ=$(echo "$abdcd" | awk '{printf("%08d\n",$0)}')
#
#echo $QQ
