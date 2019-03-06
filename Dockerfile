FROM hashicorp/terraform:latest
MAINTAINER troylar <troylar@gmail.com>
USER root
ENV TERRAFORM_VERSION=latest
ENV TERRAGRUNT_VERSION=0.18.0
ENV TERRAGRUNT_TFPATH=/bin/terraform

RUN curl -sL https://github.com/gruntwork-io/terragrunt/releases/download/v$TERRAGRUNT_VERSION/terragrunt_linux_386 \
  -o /bin/terragrunt && chmod +x /bin/terragrunt
RUN apk -v --update add \
    python \
    py-pip

RUN pip install --upgrade pip && pip install --upgrade awscli s3cmd

RUN curl -L https://github.com/Cox-Automotive/terraform-provider-alks/releases/download/1.0.0/terraform-provider-alks-linux-amd64.tar.gz | tar zxv
RUN mkdir -p /root/.terraform.d/plugins/ && \
    mv ./terraform-provider-alks_v1.0.0 /root/.terraform.d/plugins/

ENTRYPOINT ["/bin/terragrunt"]
