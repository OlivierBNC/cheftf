FROM chef/chefdk:latest

RUN apt-get update \
 && apt-get install -y \
      unzip \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip \
 && unzip terraform_0.11.11_linux_amd64.zip -d /usr/local/bin/ \
 && rm terraform_0.11.11_linux_amd64.zip

RUN wget https://github.com/wata727/tflint/releases/download/v0.7.4/tflint_linux_amd64.zip \
 && unzip tflint_linux_amd64.zip -d /usr/local/bin/ \
 && rm tflint_linux_amd64.zip

RUN gem install \
      awspec \
      kitchen-awspec \
      kitchen-terraform
