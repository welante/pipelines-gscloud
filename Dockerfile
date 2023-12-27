FROM alpine:3.16
LABEL maintainer="welante GmbH <it@welante.ch>"

# run time

# corresponds to userId
ARG GRIDSCALE_UUID
ENV GRIDSCALE_UUID=$GRIDSCALE_UUID
# corresponds to token
ARG GRIDSCALE_TOKEN
ENV GRIDSCALE_TOKEN=$GRIDSCALE_TOKEN
# corresponds to url
ARG GRIDSCALE_URL
ENV GRIDSCALE_URL=$GRIDSCALE_URL

# build time
ARG KUBE_VERSION
ENV KUBE_VERSION=$KUBE_VERSION

ARG GSCLOUD_VERSION
ENV GSCLOUD_VERSION=$GSCLOUD_VERSION

RUN apk add --update --no-cache ca-certificates openssl bash \
  && apk add --update --no-cache -t deps curl unzip

# install kubectl
RUN curl -L https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

RUN curl -L https://github.com/gridscale/gscloud/releases/download/v${GSCLOUD_VERSION}/gscloud_${GSCLOUD_VERSION}_linux_amd64.zip -o /tmp/gscloud.zip \
  && unzip /tmp/gscloud.zip -d /tmp/ \
  && mv /tmp/gscloud /usr/local/bin/gscloud \
  && chmod +x /usr/local/bin/gscloud \
  && rm /tmp/gscloud.zip \
  && apk del --purge deps

ADD config.yaml /root/.config/gridscale/config.yaml

WORKDIR /root
