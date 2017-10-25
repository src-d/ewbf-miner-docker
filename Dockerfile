FROM ubuntu:16.04

# watch out about the strange schema version with "v" and not "v" in the URL
ARG EWBF_VERSION=0.3.4b

ENV CUDA_DEVICES 0 1 2 3
ENV INTENSITY 1 1 1 1
ENV TEMPLIMIT 85
ENV PEC 1
ENV BOFF 0
ENV EEXIT 0
ENV TEMPUNITS c
ENV LOG 0
ENV LOGFILE miner.log
ENV API_PORT 42000
ENV SERVER0 zec-eu1.nanopool.org
ENV PORT0 6666
ENV SERVER1 zec-eu2.nanopool.org
ENV PORT1 6666
ENV SERVER2 zec-eu1.nanopool.org
ENV PORT2 6666
ENV EMAIL you@your.domain

EXPOSE $API_PORT

RUN apt-get update && apt-get install -y curl

WORKDIR /tmp/
RUN set -x \
  && curl -fSL https://github.com/nanopool/ewbf-miner/releases/download/v${EWBF_VERSION}/Zec.miner.${EWBF_VERSION}.Linux.Bin.tar.gz -o miner.tar.gz \
  && tar -xzvf miner.tar.gz \
  && mv miner /

COPY miner-template.cfg /
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
