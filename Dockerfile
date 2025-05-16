# Use OpenJDK 8 as base image
FROM openjdk:8-jdk

# Set environment variables
ENV HADOOP_VERSION 3.3.6
ENV HADOOP_HOME /opt/hadoop
ENV JAVA_HOME /usr/local/openjdk-8
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Install dependencies (SSH, Python, etc.)
RUN apt-get update && \
    apt-get install -y ssh rsync python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /opt && \
    mkdir -p /hadoop-logs /hadoop-data /input

# Copy Hadoop tarball from project root (now moved there) and extract
COPY hadoop-${HADOOP_VERSION}.tar.gz /tmp/
RUN tar -xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt && \
    ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && \
    rm /tmp/hadoop-${HADOOP_VERSION}.tar.gz

# Copy entrypoint script (now in root)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy mapper.py and reducer.py (now in root)
COPY mapper.py /mapper.py
COPY reducer.py /reducer.py

# Copy purchases.txt (now in root) to container's /input/
COPY purchases.txt /input/purchases.txt

# Set entrypoint
CMD ["/entrypoint.sh"]