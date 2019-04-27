
while read line
do
#echo $line
	hash=`echo $line | cut -f 1 -d ' '`
#echo $hash
	sh tryDifferentVersion.sh $hash > logs/$hash 2>&1
	retval=$?
	echo -e "$?\t$line"
done < gitLog

