#!/bin/sh
exec uwsgi --master \
    --http $HOST:$PORT \
    --module $UWSGI_MODULE \
    --processes $WORKER_PROCESSES
