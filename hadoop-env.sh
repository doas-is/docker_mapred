# Set Hadoop-specific environment variables here.

# The java implementation to use.
export JAVA_HOME=/usr/local/openjdk-8
export HADOOP_OPTS="$HADOOP_OPTS -Djava.security.krb5.realm= -Djava.security.krb5.kdc="
export HADOOP_OPTS="$HADOOP_OPTS -Dhadoop.security.authentication=simple"
# The jsvc implementation to use. Used for secure datanodes.
# export JSVC_HOME=${JSVC_HOME}

# The maximum amount of heap to use, in MB. Default is 1000.
# export HADOOP_HEAPSIZE=1000

# Extra Java runtime options.
# These can affect performance and debugging.
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true"

# Where log files are stored. $HADOOP_HOME/logs by default.
# export HADOOP_LOG_DIR=${HADOOP_HOME}/logs

# Where log files are stored in the secure data environment.
# export HADOOP_SECURE_LOG_DIR=${HADOOP_HOME}/logs

# File naming remote slave hosts. Default is ${HADOOP_HOME}/etc/hadoop/slaves.
# export HADOOP_SLAVES=${HADOOP_HOME}/etc/hadoop/slaves

# Extra ssh options.
# export HADOOP_SSH_OPTS="-o ConnectTimeout=1 -o SendEnv=HADOOP_CONF_DIR"

# Where to store process pid files. /tmp by default.
# export HADOOP_PID_DIR=/var/hadoop/pids

# History server options.
# export HADOOP_HISTORYSERVER_HEAPSIZE=1000

# Options for the various daemons.
# export HDFS_NAMENODE_OPTS=""
# export HDFS_DATANODE_OPTS=""
# export HDFS_SECONDARYNAMENODE_OPTS=""
# export YARN_RESOURCEMANAGER_OPTS=""
# export YARN_NODEMANAGER_OPTS=""

# Use these if you install native libraries
# export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native
# export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=${HADOOP_HOME}/lib/native"