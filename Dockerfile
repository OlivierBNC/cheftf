FROM chef/chefdk:latest

RUN apt-get update \
 && apt-get install -y \
      python-pip \
      unzip \
 && rm -rf /var/lib/apt/lists/*

ARG TERRAFORM_VERSION=0.11.11
RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
 && unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /usr/local/bin/ \
 && rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

ARG TFLINT_VERSION=0.7.4
RUN wget "https://github.com/wata727/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" \
 && unzip tflint_linux_amd64.zip -d /usr/local/bin/ \
 && rm tflint_linux_amd64.zip

RUN pip install awscli \
 && rm -rf /root/.cache

RUN wget https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x aws-iam-authenticator \
 && mv aws-iam-authenticator /usr/local/bin/

RUN gem install \
      awspec \
      kitchen-verifier-awspec \
      kitchen-terraform
