#!/bin/bash
tmux new-window -n zookeeper -c /opt/kafka 'sudo ./bin/zookeeper-server-start.sh config/zookeeper.properties'
tmux new-window -n kafka -c /opt/kafka 'sudo ./bin/kafka-server-start.sh config/server.properties'
tmux new-window -n druid-coordinator -c /srv/druid/current 'sudo HADOOP_USER_NAME=rustyp java -Xmx256m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -classpath config/_common:config/coordinator:lib/*:../hadoop_from_altiscale/* io.druid.cli.Main server coordinator'
tmux new-window -n druid-historical -c /srv/druid/current 'sudo HADOOP_USER_NAME=rustyp java -Xmx256m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -classpath config/_common:config/historical:lib/*:../hadoop_from_altiscale/* io.druid.cli.Main server historical' 
tmux new-window -n druid-realtime -c /srv/druid/current 'sudo HADOOP_USER_NAME=rustyp java -Xmx512m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -Ddruid.realtime.specFile=examples/wikipedia/wikipedia_realtime.spec -classpath config/_common:config/realtime:lib/*:../hadoop_from_altiscale/* io.druid.cli.Main server realtime'
tmux new-window -n druid-broker -c /srv/druid/current 'sudo HADOOP_USER_NAME=rustyp java -Xmx256m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -classpath config/_common:config/broker:lib/*:../hadoop_from_altiscale/* io.druid.cli.Main server broker'
tmux new-window -n druid-index -c /srv/druid/current 'sudo HADOOP_USER_NAME=rustyp java -Xmx2g -Duser.timezone=UTC -Dfile.encoding=UTF-8 -classpath config/_common:config/overlord:lib/*:../hadoop_from_altiscale/* io.druid.cli.Main server overlord'
