#!/bin/bash

# Copy Hadoop configuration files
cp -r /hadoop-config/* $HADOOP_HOME/etc/hadoop/

echo "Starting Hadoop on $HOSTNAME..."

# Format NameNode if needed
if [[ "$HOSTNAME" == "namenode" && ! -d "/hadoop/data/dfs/name/current" ]]; then
  echo "Formatting NameNode..."
  hdfs namenode -format -force
  sleep 5
fi

# Start services by role
case $HOSTNAME in
  namenode)
    echo "Starting NameNode..."
    hdfs namenode &
    echo "Starting ResourceMaAnager..."
    yarn resourcemanager &
    ;;

  secondary)
    echo "Starting SecondaryNameNode..."
    hdfs secondarynamenode &
    ;;

  datanode*)
    echo "Starting DataNode..."
    hdfs datanode &
    echo "Starting NodeManager..."
    yarn nodemanager &
    ;;

  *)
    echo "Unknown hostname: $HOSTNAME"
    ;;
esac

# Keep container running
tail -f /dev/null