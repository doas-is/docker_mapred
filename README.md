# docker_mapred
MapReduce & Spark Analysis with Docker
This project leverages Docker to spin up a multi-node Hadoop (MapReduce) and Apache Spark cluster for distributed data processing and analytics. By using Docker Compose, you can quickly launch a full-fledged environment with a NameNode, Secondary NameNode, and multiple DataNodes—all within isolated containers.

Note: the dataset i worked on is purchases.txt - https://www.kaggle.com/datasets/dsfelix/purchasestxt


Hadoop version that's been used is 3.3.6 :https://hadoop.apache.org/release/3.3.6.html


Features

Multi-node Hadoop (HDFS & MapReduce)
NameNode, SecondaryNameNode, and configurable number of DataNodes
Apache Spark
Pre-installed in the same image for interactive analytics and batch jobs
Dockerized
Single docker-compose up to launch the entire cluster
Customizable
Easily adjust the number of DataNodes or Spark settings via environment variables

           +-------------+          +-------------+
           |   Client    |          |   Client    |
           +-------------+          +-------------+
                  |                       |
                  v                       v
            Docker Bridge Network (hadoop-net)
                  |                       |
  +----------------+-----------------------+------------------+
  |                |                       |                  |
+--------+     +-------------+      +-------------+      +-------------+
|NameNode|<--->| Secondary   |      | DataNode 1  | ...  | DataNode N  |
|        |     | NameNode    |      |             |      |             |
+--------+     +-------------+      +-------------+      +-------------+
Spark is installed on each node; submit jobs via the NameNode container.


Repository Structure

├── Dockerfile            # Builds Hadoop+Spark image
├── docker-compose.yml    # Defines NameNode, Secondary, DataNodes
├── entrypoint.sh         # Container startup script
├── hadoop-3.3.6.tar.gz   # (optional, if not using wget in Dockerfile)
├── config/               # Hadoop & Spark configuration files
│   ├── core-site.xml
│   ├── hdfs-site.xml
│   ├── spark-env.sh
│   └── workers
└── README.md      



Contributions are welcome! Feel free to open issues or submit pull requests.
