# Joseph Spear 8/19/21
#
# This file will take in a specific string format containing hex data, parse the important data,
# convert the hex string into a base 10 integer, and then plot the data using gnuplot



if [[ $1 == "serial_"* ]];then

    # Assigns variables for the I/O Arguments
    INPUT_FILE=$1

    # cat's the Input file and then searches for the timestamp (first line with a size of exactly 9)
    LINES=`cat $INPUT_FILE`
    for LINE in $LINES
    do
        LENGTH=`expr length "$LINE"`
        if [[ $LENGTH == 9 ]];then
        TIMESTAMP=${LINE:0:8}
        break
        fi
    done

    # Makes the new Directory and output file
    DIRECTORY_NAME=Data_$TIMESTAMP
    mkdir $DIRECTORY_NAME
    OUTPUT_FILE=./$DIRECTORY_NAME/Raw_Data_$TIMESTAMP.txt
    touch $OUTPUT_FILE


    # Cut all of the data to be 4 characters long, starting at the first character of data (OUTPUT_FILE is actinga as a temp file here because it will be rewritten later)
    cat $INPUT_FILE | cut -c  14-17 | cat > $OUTPUT_FILE


    # Variable to help parse the data
    LINES=`cat $OUTPUT_FILE`

    # Rewrite OUTPUT_FILE with the very first line being the Timestamp
    echo "$TIMESTAMP" > "$OUTPUT_FILE"

    # For loop to go through the LINES set, writing proper data to OUTPUT_FILE, and ignoring improper data
    for LINE in $LINES
    do
        VAR=${LINE:0:1}

        LENGTH=`expr length "$LINE"`
        if [[ "$VAR" == '~' ]]; then
            echo ''
        elif [[ $LENGTH != 4 ]]; then
            echo ''
        else
            echo "$LINE" >> "$OUTPUT_FILE"
        fi
    done

    # Remove the second line and extra data from OUTPUT_FILE. It is a repeat of the Timestamp
    sed -i '2d' $OUTPUT_FILE
    sed -i '3202,$ d' $OUTPUT_FILE

    # File used to store Base 10 values
    DECIMAL_FILE=./$DIRECTORY_NAME/Raw_Data_inDecimal_$TIMESTAMP.txt
    touch $DECIMAL_FILE

    # Puts all of the data from Output into the Base 10 file, excluding the timestamp. Just sound data
    sed '1d' $OUTPUT_FILE > $DECIMAL_FILE

    # Variable to help parse the data
    LINES=`cat $DECIMAL_FILE`

    # Erase all data on the file to write anew
    echo > $DECIMAL_FILE

    # Actual conversion from Hex to Base 10 occurs here
    for LINE in $LINES
    do
        CHAR1=${LINE:0:1}
        case $CHAR1 in
            "0") declare -i NUM1 && NUM1=0;;
            "1") declare -i NUM1 && NUM1=1;;
            "2") declare -i NUM1 && NUM1=2;;
            "3") declare -i NUM1 && NUM1=3;;
            "4") declare -i NUM1 && NUM1=4;;
            "5") declare -i NUM1 && NUM1=5;;
            "6") declare -i NUM1 && NUM1=6;;
            "7") declare -i NUM1 && NUM1=7;;
            "8") declare -i NUM1 && NUM1=8;;
            "9") declare -i NUM1 && NUM1=9;;
            "a") declare -i NUM1 && NUM1=10;;
            "b") declare -i NUM1 && NUM1=11;;
            "c") declare -i NUM1 && NUM1=12;;
            "d") declare -i NUM1 && NUM1=13;;
            "e") declare -i NUM1 && NUM1=14;;
            "f") declare -i NUM1 && NUM1=15;;
        esac
        
        NUM1=$NUM1*16*16*16
        


        CHAR2=${LINE:1:1}
            case $CHAR2 in
            "0") declare -i NUM2 && NUM2=0;;
            "1") declare -i NUM2 && NUM2=1;;
            "2") declare -i NUM2 && NUM2=2;;
            "3") declare -i NUM2 && NUM2=3;;
            "4") declare -i NUM2 && NUM2=4;;
            "5") declare -i NUM2 && NUM2=5;;
            "6") declare -i NUM2 && NUM2=6;;
            "7") declare -i NUM2 && NUM2=7;;
            "8") declare -i NUM2 && NUM2=8;;
            "9") declare -i NUM2 && NUM2=9;;
            "a") declare -i NUM2 && NUM2=10;;
            "b") declare -i NUM2 && NUM2=11;;
            "c") declare -i NUM2 && NUM2=12;;
            "d") declare -i NUM2 && NUM2=13;;
            "e") declare -i NUM2 && NUM2=14;;
            "f") declare -i NUM2 && NUM2=15;;
        esac
        
        NUM2=$NUM2*16*16
        

        CHAR3=${LINE:2:1}
            case $CHAR3 in
            "0") declare -i NUM3 && NUM3=0;;
            "1") declare -i NUM3 && NUM3=1;;
            "2") declare -i NUM3 && NUM3=2;;
            "3") declare -i NUM3 && NUM3=3;;
            "4") declare -i NUM3 && NUM3=4;;
            "5") declare -i NUM3 && NUM3=5;;
            "6") declare -i NUM3 && NUM3=6;;
            "7") declare -i NUM3 && NUM3=7;;
            "8") declare -i NUM3 && NUM3=8;;
            "9") declare -i NUM3 && NUM3=9;;
            "a") declare -i NUM3 && NUM3=10;;
            "b") declare -i NUM3 && NUM3=11;;
            "c") declare -i NUM3 && NUM3=12;;
            "d") declare -i NUM3 && NUM3=13;;
            "e") declare -i NUM3 && NUM3=14;;
            "f") declare -i NUM3 && NUM3=15;;
        esac
        
        NUM3=$NUM3*16


        CHAR4=${LINE:3:1}
        case $CHAR4 in
            "0") declare -i NUM4 && NUM4=0;;
            "1") declare -i NUM4 && NUM4=1;;
            "2") declare -i NUM4 && NUM4=2;;
            "3") declare -i NUM4 && NUM4=3;;
            "4") declare -i NUM4 && NUM4=4;;
            "5") declare -i NUM4 && NUM4=5;;
            "6") declare -i NUM4 && NUM4=6;;
            "7") declare -i NUM4 && NUM4=7;;
            "8") declare -i NUM4 && NUM4=8;;
            "9") declare -i NUM4 && NUM4=9;;
            "a") declare -i NUM4 && NUM4=10;;
            "b") declare -i NUM4 && NUM4=11;;
            "c") declare -i NUM4 && NUM4=12;;
            "d") declare -i NUM4 && NUM4=13;;
            "e") declare -i NUM4 && NUM4=14;;
            "f") declare -i NUM4 && NUM4=15;;
        esac
        
        NUM4=$NUM4

        # The following few lines make sure the data comes in between -32767 and +32767. Range is initially between 0 and 65536
        declare -i TOTAL
        declare -i TEMP
        declare -i TOPVALUE
        TOPVALUE=32766
        TEMP=$NUM1+$NUM2+$NUM3+$NUM4
        echo $TEMP

        if [[ $TEMP -ge $TOPVALUE ]]; then
            TOTAL=($TEMP-65536)
        else
            TOTAL=$TEMP
        fi

        echo $TOTAL
        echo ''
        # Here the calculated value is appended to the Base 10 file
        echo $TOTAL >> $DECIMAL_FILE

    done

    # Remove the initial blank line
    sed -i "1d" $DECIMAL_FILE

    # Variable to gather the proper file name
    NAME="SOUND_GRAPH_$TIMESTAMP"

    # Gnuplot execution to generate a .png file
    /usr/bin/gnuplot -e "set terminal png; set title 'Data Acquisition. Timestamp: $TIMESTAMP'; set output '$DIRECTORY_NAME/$NAME.png'; \
    set xlabel 'Sample Number'; set ylabel 'Sound Amplitude'; plot '~/Desktop/AudioPlotting/$DECIMAL_FILE' smooth bezier title '$TIMESTAMP'"

    # Copy the file into the parent directory. To be used when creating All_Plot.png
    cp Data_*/Raw_Data_inDecimal_*.txt ./

# End of the If case








elif [[ $1 == "-a" ]];then
    
# Assigns variables for the I/O Arguments
    INPUT_FILES=serial_*.txt

    # This loop goes through all matching files, and performs the same operation as the initial case for this if statement
    for INPUT_FILE in $INPUT_FILES
    do
        # cat's the Input file and then searches for the timestamp (first line with a size of exactly 9)
        LINES=`cat $INPUT_FILE`
        for LINE in $LINES
        do
            LENGTH=`expr length "$LINE"`
            if [[ $LENGTH == 9 ]];then
            TIMESTAMP=${LINE:0:8}
            break
            fi
        done

        DIRECTORY_NAME=Data_$TIMESTAMP
        mkdir $DIRECTORY_NAME


        OUTPUT_FILE=./$DIRECTORY_NAME/Raw_Data_$TIMESTAMP.txt
        touch $OUTPUT_FILE


        # Cut all of the data to be 4 characters long, starting at the first character of data (OUTPUT_FILE is actinga as a temp file here because it will be rewritten later)
        cat $INPUT_FILE | cut -c  14-17 | cat > $OUTPUT_FILE

        LINES=`cat $OUTPUT_FILE`

        # Rewrite OUTPUT_FILE with the very first line being the Timestamp
        echo "$TIMESTAMP" > "$OUTPUT_FILE"

        # For loop to go through the LINES set, writing proper data to OUTPUT_FILE, and ignoring improper data
        for LINE in $LINES
        do
            VAR=${LINE:0:1}

            LENGTH=`expr length "$LINE"`
            if [[ "$VAR" == '~' ]]; then
                echo ''
            elif [[ $LENGTH != 4 ]]; then
                echo ''
            else
                echo "$LINE" >> "$OUTPUT_FILE"
            fi
        done

    # Remove the second line and extra data from OUTPUT_FILE. It is a repeat of the Timestamp
    sed -i '2d' $OUTPUT_FILE
    sed -i '3202,$ d' $OUTPUT_FILE

    # File used to store Base 10 values
    DECIMAL_FILE=./$DIRECTORY_NAME/Raw_Data_inDecimal_$TIMESTAMP.txt
    touch $DECIMAL_FILE

    # Puts all of the data from Output into the Base 10 file, excluding the timestamp. Just sound data
    sed '1d' $OUTPUT_FILE > $DECIMAL_FILE

    # Variable to help parse the data
    LINES=`cat $DECIMAL_FILE`

    # Erase all data on the file to write anew
    echo > $DECIMAL_FILE

    # Actual conversion from Hex to Base 10 occurs here
    for LINE in $LINES
    do
        CHAR1=${LINE:0:1}
        case $CHAR1 in
            "0") declare -i NUM1 && NUM1=0;;
            "1") declare -i NUM1 && NUM1=1;;
            "2") declare -i NUM1 && NUM1=2;;
            "3") declare -i NUM1 && NUM1=3;;
            "4") declare -i NUM1 && NUM1=4;;
            "5") declare -i NUM1 && NUM1=5;;
            "6") declare -i NUM1 && NUM1=6;;
            "7") declare -i NUM1 && NUM1=7;;
            "8") declare -i NUM1 && NUM1=8;;
            "9") declare -i NUM1 && NUM1=9;;
            "a") declare -i NUM1 && NUM1=10;;
            "b") declare -i NUM1 && NUM1=11;;
            "c") declare -i NUM1 && NUM1=12;;
            "d") declare -i NUM1 && NUM1=13;;
            "e") declare -i NUM1 && NUM1=14;;
            "f") declare -i NUM1 && NUM1=15;;
        esac
        
        NUM1=$NUM1*16*16*16


        CHAR2=${LINE:1:1}
            case $CHAR2 in
            "0") declare -i NUM2 && NUM2=0;;
            "1") declare -i NUM2 && NUM2=1;;
            "2") declare -i NUM2 && NUM2=2;;
            "3") declare -i NUM2 && NUM2=3;;
            "4") declare -i NUM2 && NUM2=4;;
            "5") declare -i NUM2 && NUM2=5;;
            "6") declare -i NUM2 && NUM2=6;;
            "7") declare -i NUM2 && NUM2=7;;
            "8") declare -i NUM2 && NUM2=8;;
            "9") declare -i NUM2 && NUM2=9;;
            "a") declare -i NUM2 && NUM2=10;;
            "b") declare -i NUM2 && NUM2=11;;
            "c") declare -i NUM2 && NUM2=12;;
            "d") declare -i NUM2 && NUM2=13;;
            "e") declare -i NUM2 && NUM2=14;;
            "f") declare -i NUM2 && NUM2=15;;
        esac
        
        NUM2=$NUM2*16*16


        CHAR3=${LINE:2:1}
            case $CHAR3 in
            "0") declare -i NUM3 && NUM3=0;;
            "1") declare -i NUM3 && NUM3=1;;
            "2") declare -i NUM3 && NUM3=2;;
            "3") declare -i NUM3 && NUM3=3;;
            "4") declare -i NUM3 && NUM3=4;;
            "5") declare -i NUM3 && NUM3=5;;
            "6") declare -i NUM3 && NUM3=6;;
            "7") declare -i NUM3 && NUM3=7;;
            "8") declare -i NUM3 && NUM3=8;;
            "9") declare -i NUM3 && NUM3=9;;
            "a") declare -i NUM3 && NUM3=10;;
            "b") declare -i NUM3 && NUM3=11;;
            "c") declare -i NUM3 && NUM3=12;;
            "d") declare -i NUM3 && NUM3=13;;
            "e") declare -i NUM3 && NUM3=14;;
            "f") declare -i NUM3 && NUM3=15;;
        esac
        
        NUM3=$NUM3*16


        CHAR4=${LINE:3:1}
        case $CHAR4 in
            "0") declare -i NUM4 && NUM4=0;;
            "1") declare -i NUM4 && NUM4=1;;
            "2") declare -i NUM4 && NUM4=2;;
            "3") declare -i NUM4 && NUM4=3;;
            "4") declare -i NUM4 && NUM4=4;;
            "5") declare -i NUM4 && NUM4=5;;
            "6") declare -i NUM4 && NUM4=6;;
            "7") declare -i NUM4 && NUM4=7;;
            "8") declare -i NUM4 && NUM4=8;;
            "9") declare -i NUM4 && NUM4=9;;
            "a") declare -i NUM4 && NUM4=10;;
            "b") declare -i NUM4 && NUM4=11;;
            "c") declare -i NUM4 && NUM4=12;;
            "d") declare -i NUM4 && NUM4=13;;
            "e") declare -i NUM4 && NUM4=14;;
            "f") declare -i NUM4 && NUM4=15;;
        esac
        
        NUM4=$NUM4


        # The following few lines make sure the data comes in between -32767 and +32767. Range is initially between 0 and 65536
        declare -i TOTAL
        declare -i TEMP
        declare -i TOPVALUE
        TOPVALUE=32766
        TEMP=$NUM1+$NUM2+$NUM3+$NUM4
        echo $TEMP

        if [[ $TEMP -ge $TOPVALUE ]]; then
            TOTAL=($TEMP-65536)
        else
            TOTAL=$TEMP
        fi

        # Here the calculated value is appended to the Base 10 file
        echo $TOTAL >> $DECIMAL_FILE

    done

    # Removing the inital blank line in the Base 10 file
    sed -i "1d" $DECIMAL_FILE

    # Variable to gather the proper file name
    NAME="SOUND_GRAPH_$TIMESTAMP"

    # Gnuplot execution to generate a .png file of all the data in each of their folders
    /usr/bin/gnuplot -e "set terminal png; set title 'Data Acquisition. Timestamp: $TIMESTAMP'; set output '$DIRECTORY_NAME/$NAME.png'; \
    set xlabel 'Sample Number'; set ylabel 'Sound Amplitude'; plot '~/Desktop/AudioPlotting/$DECIMAL_FILE' smooth bezier title '$TIMESTAMP'"

    # Copy the file into the parent directory. To be used when creating All_Plot.png
    cp Data_*/Raw_Data_inDecimal_*.txt ./

done

# End of the If case









elif [[ $1 == "-p" || $1 == "" ]];then

    # Sets up variables to be used when generating All_Plot.png
    NAME=All_Plot
    RAW_FILES=( Raw_Data_inDecimal_* ) 
    NUM_FILES=${#RAW_FILES[@]}
    
    # For loop to rename all the files. This makes it easier to make a for loop in the gnuplot call
    for(( i=0; i < $NUM_FILES; i++ ))
    do
        declare -i j
        j=$i+1
        mv -u ${RAW_FILES[i]} Raw_Data_inDecimal_$j.txt
    done
 
    # Generate All_Plot.png from all the Raw Base 10 files currently in this directory
    /usr/bin/gnuplot -e "set terminal png; set key off; set title 'Data Acquisition. All Data'; set output '$NAME.png'; \
    set xlabel 'Sample Number'; set ylabel 'Sound Amplitude'; plot for[i = 1:$NUM_FILES] 'Raw_Data_inDecimal_'.i.'.txt' smooth bezier title ''.i.''"

    # Remove all of the Raw files in this directory
    rm Raw_Data_inDecimal_*.txt

# End of the If case









else # Help case
    echo -e "Usage: $0 [optional <file>] [flag]\n"
    echo -e "\n"

    echo -e "------------------------------------------------------------------------------"
    echo -e "|Options:                                                                     |"
    echo -e "|                                                                             |"
    echo -e "|  -h, Print this help menu.                                                  |"
    echo -e "|  -p, Plot all of the Raw data .txt files on one plot.                       |"
    echo -e "|  -a, Perform the conversion and mkdir with all initial .txt files.          |"
    echo -e "------------------------------------------------------------------------------\n"
    echo -e "\n"

fi
