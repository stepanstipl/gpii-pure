FROM alpine:3.7

ENV TERRAFORM_VERSION=0.11.7 \
    KUBECTL_VERSION=1.11.1 \
    HELM_VERSION=2.10.0-rc.2 \
    HELM_PROVIDER_VERSION=0.5.1 \
    GOOGLE_CLOUD_SDK_VERSION=210.0.0 \
    PATH=${PATH}:/opt/bin:/opt/google-cloud-sdk/bin

RUN apk --update --no-cache add \
        bash \
        ca-certificates \
        curl \
        git \
        jq \
        libc6-compat \
        make \
        openssl \
        py-crcmod \
        python \
        tar \
        tzdata \
    && mkdir -p /opt/bin \
    # Terraform
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /opt/bin \
    && rm /tmp/terraform.zip \
    && mkdir -p /root/.terraform.d/plugins/linux_amd64 \
    # Kubectl
    && wget https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /opt/bin/kubectl \
    && chmod +x /opt/bin/kubectl \
    # Google Cloud SDK
    && wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz -O /tmp/gsdk.tar.gz \
    && tar -xvzf /tmp/gsdk.tar.gz -C /opt \
    && rm /tmp/gsdk.tar.gz \
    && ln -s /lib /lib64 \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image \
    && gcloud components install alpha beta \
    && gcloud components update \
    && gcloud config set component_manager/disable_update_check true \
    # Helm
    && wget https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O /tmp/helm.tar.gz \
    && tar -xvzf /tmp/helm.tar.gz -C /opt/bin linux-amd64/helm --strip-components=1 \
    && chmod +x /opt/bin/helm \
    && rm /tmp/helm.tar.gz \
    # Helm provider
    && wget https://github.com/mcuadros/terraform-provider-helm/releases/download/v${HELM_PROVIDER_VERSION}/terraform-provider-helm_v${HELM_PROVIDER_VERSION}_linux_amd64.tar.gz -O /tmp/helm-provider.tgz \
    && tar -xvzf /tmp/helm-provider.tgz --strip-components=1 \
    && mv terraform-provider-helm /root/.terraform.d/plugins/linux_amd64/terraform-provider-helm_v${HELM_PROVIDER_VERSION} \
    && rm /tmp/helm-provider.tgz
    # This is us

COPY . /gpii-pure
WORKDIR /gpii-pure

RUN terraform init -input=false -backend=false

ENTRYPOINT ["/usr/bin/make"]
