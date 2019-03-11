FROM hashicorp/terraform:0.11.13
MAINTAINER troylar <troylar@gmail.com>
USER root

RUN apk -v --update add \
    python \
    py-pip

RUN pip install --upgrade pip && pip install --upgrade awscli s3cmd

ENV ALKS_PROVIDER_VERSION=1.2.1
ENV TERRAGRUNT_VERSION=0.18.1
ENV TERRAGRUNT_TFPATH=/bin/terraform

RUN curl -L https://github.com/Cox-Automotive/terraform-provider-alks/releases/download/$ALKS_PROVIDER_VERSION/terraform-provider-alks-linux-amd64.tar.gz | tar zxv
RUN mkdir -p /root/.terraform.d/plugins/ && \
    mv ./terraform-provider-alks_v$ALKS_PROVIDER_VERSION /root/.terraform.d/plugins/
RUN curl -sL https://github.com/gruntwork-io/terragrunt/releases/download/v$TERRAGRUNT_VERSION/terragrunt_linux_386 \
  -o /bin/terragrunt && chmod +x /bin/terragrunt

ENTRYPOINT ["/bin/terragrunt"]
