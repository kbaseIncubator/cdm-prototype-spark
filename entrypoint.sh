#!/bin/bash

# run spark in the foreground so the container doesn't immediately exit
export SPARK_NO_DAEMONIZE=true
export SPARK_MASTER_HOST=0.0.0.0
export SPARK_MASTER_PORT=$PORT
export SPARK_MASTER_WEBUI_PORT=$WEBPORT
export SPARK_WORKER_WEBUI_PORT=$WEBPORT

if [ "$MODE" == "master" ] ; then
    echo "starting spark master"
    /opt/spark/sbin/start-master.sh
elif [ "$MODE" == "worker" ] ; then
    echo "starting spark worker"
    /opt/spark/sbin/start-worker.sh --cores "$CORES" --memory "$MEM" "$SPARK_MASTER_URL"
elif [ "$MODE" == "bash" ] ; then
  bash
else
  echo "Unrecognized MODE env var: [$MODE]"
fi
