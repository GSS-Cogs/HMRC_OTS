FROM python:3-alpine

RUN \
     apk add --no-cache libxslt libxml2 libstdc++ \
  && apk add --no-cache -t .dev g++ python3-dev libxml2-dev libxslt-dev \
  && pip install --no-cache-dir jupyter databaker pandas requests \
  && apk del .dev

VOLUME /workspace
WORKDIR /workspace
