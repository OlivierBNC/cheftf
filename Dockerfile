FROM chef/chefdk:latest

# Install APT Packages
RUN apt-get update \
 && apt-get install -y \
      docker.io \
      git \
      git-crypt \
      gpg \
      gpg-agent \
      python-pip \
      unzip \
 && rm -rf /var/lib/apt/lists/*

# Install Python Packages
RUN pip install \
      awscli \
 && rm -rf /root/.cache

# Install Ruby Gems
RUN gem install \
      awspec \
      kitchen-verifier-awspec \
      kitchen-terraform

# Install other binaries

ARG AWSCLI_VERSION=1.11.5
RUN wget https://amazon-eks.s3-us-west-2.amazonaws.com/${AWSCLI_VERSION}/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x aws-iam-authenticator \
 && mv aws-iam-authenticator /usr/local/bin/

ARG HELM_VERSION=2.13.0
RUN wget "https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
 && tar -xzf "helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
 && mv linux-amd64/helm /usr/local/bin/ \
 && rm -rf "helm-v${HELM_VERSION}-linux-amd64.tar.gz" linux-amd64

ARG KUBECTL_VERSION=1.13.4
RUN wget "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/

ARG TERRAFORM_VERSION=0.11.11
RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
 && unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /usr/local/bin/ \
 && rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

ARG TFLINT_VERSION=0.7.4
RUN wget "https://github.com/wata727/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" \
 && unzip tflint_linux_amd64.zip -d /usr/local/bin/ \
 && rm tflint_linux_amd64.zip
