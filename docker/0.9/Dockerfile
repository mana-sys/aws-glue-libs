# This Docker file is based on the glue-setup.sh script.
FROM maven:3.6.3-jdk-8-slim

# Install Python 2.7
RUN apt-get update && apt-get install -y python python-pip zip

# Install Spark 2.2.1
RUN curl -O https://aws-glue-etl-artifacts.s3.amazonaws.com/glue-0.9/spark-2.2.1-bin-hadoop2.7.tgz &&\
    tar -C /usr/local -xzf spark-2.2.1-bin-hadoop2.7.tgz &&\
    rm spark-2.2.1-bin-hadoop2.7.tgz

ENV SPARK_HOME /usr/local/spark-2.2.1-bin-hadoop2.7

RUN pip install pytest

ENV GLUE_LIBS_ROOT /aws-glue-libs

# Retrieve dependency JARs for AWS Glue libraries.
ADD pom.xml $GLUE_LIBS_ROOT/
ADD awsglue $GLUE_LIBS_ROOT/awsglue
RUN mvn -f $GLUE_LIBS_ROOT/pom.xml -DoutputDirectory=$GLUE_LIBS_ROOT/jars dependency:copy-dependencies

# Set up AWS Glue Python package.
RUN mkdir $GLUE_LIBS_ROOT/dist/ &&\
    cd $GLUE_LIBS_ROOT &&\
    zip -r dist/awsglue.zip awsglue/

# Set up PYTHONPATH
ENV PYTHONPATH $GLUE_LIBS_ROOT/dist/awsglue.zip:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$SPARK_HOME/python/:$PYTHONPATH

# Spark configuration for adding Glue libraries to class path.
RUN echo "spark.driver.extraClassPath $GLUE_LIBS_ROOT/jars/*" >> $SPARK_HOME/conf/spark-defaults.conf &&\
    echo "spark.executor.extraClassPath $GLUE_LIBS_ROOT/jars/*" >> $SPARK_HOME/conf/spark-defaults.conf

WORKDIR /project

# Get rid of Maven entrypoint.
ENTRYPOINT ["/bin/bash"]