FROM docker:latest
RUN apk -v --update add \
        bash \
        curl \
        jq \
        && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
ENTRYPOINT []
