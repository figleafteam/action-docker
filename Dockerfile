FROM docker

LABEL "com.github.actions.name"="Docker Push"
LABEL "com.github.actions.description"="build, tag and pushes the container"
LABEL "com.github.actions.icon"="anchor"
LABEL "com.github.actions.color"="blue"

LABEL version=v0.2.8
LABEL repository="https://github.com/figleafteam/action-docker"
LABEL maintainer="Valentyn Nastenko <nastenko@figleaf.com>"

RUN apk add -v --update bash curl python py-pip jq git file tar && \
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing hub

# awscli
ENV awscli 1.18.51
RUN pip install --upgrade awscli==${awscli} && \
    apk del -v --purge py-pip && \
    rm /var/cache/apk/*

VOLUME /root/.aws

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
