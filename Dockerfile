FROM golang:1.19-loongnix

ARG FZF_VERSION=0.34.0

ENV FZF_VERSION=${FZF_VERSION}

RUN set -ex; \
    git clone -b ${FZF_VERSION} https://github.com/junegunn/fzf /opt/fzf

WORKDIR /opt/fzf

ENV GOPROXY=https://goproxy.io \
    CGO_ENABLED=0

RUN set -ex; \
    make

RUN set -ex; \
    mkdir /opt/fzf/dist; \
    mv target/fzf-linux_loong64 target/fzf; \
    cd target; \
    tar czf /opt/fzf/dist/fzf-${FZF_VERSION}-linux_loong64.tar.gz .; \
    cd /opt/fzf/dist; \
    sha256sum fzf-${FZF_VERSION}-linux_loong64.tar.gz | tee fzf_${FZF_VERSION}_checksums.txt

VOLUME /dist

CMD cp -rf dist/* /dist/
