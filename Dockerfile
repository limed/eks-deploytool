FROM alpine:latest

ENV KUBE_VERSION="v1.15.1"

RUN apk add --update --no-cache \
	ca-certificates \
	py-pip \
	jq \
	curl  \
	bash && \
	curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
	chmod +x /usr/local/bin/kubectl && \
	mkdir -p /code && \
	pip install awscli yq j2cli --no-cache-dir

WORKDIR /code
COPY bin /usr/local/bin/
