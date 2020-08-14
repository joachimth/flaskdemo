# Build container
FROM alpine:3.10 as build

RUN mkdir /build /wheelhouse
WORKDIR /build

ADD requirements.txt requirements.txt
ADD setup.py setup.py
ADD src src
ADD apk-build-packages.txt packages.txt

RUN xargs apk --no-cache add < packages.txt
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade wheel
RUN pip3 wheel -w /wheelhouse /build uwsgi


# UWSGI Runtime container
FROM alpine:3.10 as runtime

RUN adduser --system --home=/opt/app demo_app
RUN mkdir -p /opt/app
WORKDIR /opt/app

ADD apk-runtime-packages.txt packages.txt
RUN xargs apk --no-cache add < packages.txt
RUN pip3 install --upgrade pip

COPY --from=build /wheelhouse /wheelhouse
RUN pip3 install -f /wheelhouse flask-demo-app uwsgi
ADD start.sh /usr/local/bin/start.sh

ENV HOST=0.0.0.0
ENV PORT=8080
ENV UWSGI_MODULE=demo_app:app
ENV WORKER_PROCESSES=4

USER demo_app

ENTRYPOINT []
CMD ["start.sh"]
