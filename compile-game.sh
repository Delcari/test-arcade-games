GAME_DIR=$1
BINARY_SUFFIX=$2             

cd $GITHUB_WORKSPACE/$GAME_DIR

file=config.txt
sed -i "s/\r//g" "${file}"
while read line || [ -n "$line" ]; do
	if [[ ${line:0:1} == *"#"* ]] || [[ -z $line ]]; then
		continue
	fi
	IFS='=' read -ra item <<< $line
	if [[ ${item[0]} == "compile-command" ]]; then
		command="${item[1]}"
		break
	fi
done < $file

game_name=$(basename $GAME_DIR)
echo Compiling game $game_name...
if [[ -z "$command" ]]; then
	echo "No compile command found, using default"
	skm g++ program.cpp -o ${game_name}-$BINARY_SUFFIX
else
	if [[ $command == "skm"* ]]; then
	echo Appending output flag and name/loc 
	command+=" -o ${game_name}-$BINARY_SUFFIX"
	else
	echo Assuming usage of makefile, appending output name/loc 
	command+=" ${game_name}-$BINARY_SUFFIX"
	fi
	echo "Running compile command: $command"
	eval $command
fi
done  