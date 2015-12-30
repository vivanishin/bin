$D8_PATH/d8 $1 --prof --log-timer-events
$D8_PATH/../../tools/linux-tick-processor > profile$1.txt
$D8_PATH/../../tools/plot-timer-events v8.log
mv timer-events.png timer-events$1.png 
