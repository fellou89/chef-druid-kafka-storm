# This is as pasted from chat.  It may not work, but it's here for documentation purposes.

bin/zookeeper-server-start.sh config/zookeeper.properties

bin/kafka-server-start.sh config/server.properties

bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic testing

bin/kafka-console-producer.sh --broker-list localhost:9092 --topic testing

bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic testing --from-beginning
