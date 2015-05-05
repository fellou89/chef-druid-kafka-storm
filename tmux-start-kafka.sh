KAFKA_DIR="/opt/kafka"
USE_TMUX=1

function tmux_or_background {
  eval $([ "$USE_TMUX" ] && echo "tmux new-window -c $2 -n $1 '$3'" || echo "$3 &"  )
}

tmux_or_background zookeeper $KAFKA_DIR "sudo ./bin/zookeeper-server-start.sh config/zookeeper.properties"
tmux_or_background kafka $KAFKA_DIR "sudo ./bin/kafka-server-start.sh config/server.properties"
