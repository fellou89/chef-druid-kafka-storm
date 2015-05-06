#!/bin/bash
USE_TMUX=0

DRUID_CLASSPATH="config/_common:lib/*"
DRUID_CMD_START="sudo HADOOP_USER_NAME=rustyp java -Xmx512m -Duser.timezone=UTC -Dfile.encoding=UTF-8"
DRUID_MAIN_CLASS="io.druid.cli.Main"
DRUID_DIR="/srv/druid/current"
DRUID_PARTS=(coordinator historical realtime broker overlord)

function tmux_or_background {
 #tmux send-keys -t $1 C-z
  eval $([ "$USE_TMUX" ] && echo "tmux new-window -c $2 -n $1 '$3'" || echo "$3 &"  )
}

for i in "${DRUID_PARTS[@]}"
do
  tmux_or_background "druid-$i" $DRUID_DIR "$DRUID_CMD_START -classpath config/$i:$DRUID_CLASSPATH $DRUID_MAIN_CLASS server $i" 
done
