FROM sysmana/aws-glue-dev-base:0.9
WORKDIR /project
ENTRYPOINT ["/usr/local/spark-2.2.1-bin-hadoop2.7/bin/spark-submit", "--py-files", "/aws-glue-libs/dist/awsglue.zip"]