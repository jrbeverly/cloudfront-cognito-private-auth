FROM gitpod/workspace-full
USER root

RUN mkdir $HOME/bin
RUN npm install -g @bazel/bazelisk
RUN npm install -g @bazel/ibazel

ARG CONFTEST_URL="https://github.com/open-policy-agent/conftest/releases/download/v0.32.0/conftest_0.32.0_linux_amd64.deb"
RUN curl -sSL "${CONFTEST_URL}" -o conftest.deb \
    && dpkg -i conftest.deb \
    && rm conftest.deb

ARG TERRAFORM_URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip"
RUN curl -sSL "${TERRAFORM_URL}" -o terraform.zip \
    && unzip terraform.zip \
    && rm terraform.zip \
    && chmod +x terraform \
    && mv terraform /usr/local/bin/terraform

ARG BAZEL_BUILDTOOLS_URL="https://github.com/bazelbuild/buildtools/releases/download"
RUN curl -sSL "${BAZEL_BUILDTOOLS_URL}/5.1.0/buildozer-linux-amd64" > /usr/local/bin/buildozer && \
    curl -sSL "${BAZEL_BUILDTOOLS_URL}/5.1.0/buildifier-linux-amd64" >  /usr/local/bin/buildifier && \
    chmod +x /usr/local/bin/buildozer && \
    chmod +x /usr/local/bin/buildifier 

RUN curl -sSL "https://github.com/go-swagger/go-swagger/releases/download/v0.29.0/swagger_linux_amd64" > /usr/local/bin/swagger && \
    chmod +x /usr/local/bin/swagger

ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
RUN curl "${AWS_CLI_V2_URL}" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

ARG KUBECTL_URL='https://amazon-eks.s3.us-west-2.amazonaws.com/1.20.4/2021-04-12/bin/linux/amd64/kubectl'
RUN curl -o kubectl "${KUBECTL_URL}" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin

ARG YQ_URL='https://github.com/mikefarah/yq/releases/download/v4.18.1/yq_linux_amd64'
RUN curl -o yq "${KUBECTL_URL}" && \
    chmod +x yq && \
    mv yq /usr/local/bin

USER gitpod