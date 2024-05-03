# Would much prefer to use an official image, but it looks like they're just for submitting jobs
# rather than running a cluster?
# https://github.com/apache/spark-docker/blob/master/3.5.1/scala2.12-java17-ubuntu/entrypoint.sh
# Can't seem to find any usage documentation, so've just been reading the code to figure out how
# they work

FROM ubuntu:22.04 as build

RUN apt update -y
RUN apt install -y wget

ENV SPARK_VER=spark-3.5.1-bin-hadoop3-scala2.13

WORKDIR /opt
# TODO should at least check the sha, or copy the pgp check from the official dockerfile
RUN wget -q https://dlcdn.apache.org/spark/spark-3.5.1/$SPARK_VER.tgz && \
    tar -xf $SPARK_VER.tgz


FROM eclipse-temurin:17.0.11_9-jre-jammy

WORKDIR /opt
COPY --from=build /opt/$SPARK_VER/* /opt/spark/ 
COPY entrypoint.sh /opt/
RUN chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
