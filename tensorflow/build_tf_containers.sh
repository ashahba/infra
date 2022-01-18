#!/usr/bin/env bash

set -xe

source ./common_env.sh

export UBUNTU_IMAGE_TAG=${UBUNTU_IMAGE_TAG:-${TF_DOCKER_BUILD_VERSION}-icx-server-ubuntu}
export DEBIAN_IMAGE_TAG=${DEBIAN_IMAGE_TAG:-${TF_DOCKER_BUILD_VERSION}-icx-server-debian}
export CENTOS_IMAGE_TAG=${CENTOS_IMAGE_TAG:-${TF_DOCKER_BUILD_VERSION}-icx-server-centos}

echo ${TENSORFLOW_SRCS} > .dockerignore
echo ${TENSORFLOW_WHLS} >> .dockerignore

export TENSORFLOW_WHLS_TEMP=${TENSORFLOW_WHLS_TEMP-tmp_whls}
rm -rf ${TENSORFLOW_WHLS_TEMP}
cp -rp ${TENSORFLOW_WHLS}/pip3 ${TENSORFLOW_WHLS_TEMP}

# docker build \
#     --build-arg HTTP_PROXY=${HTTP_PROXY} \
#     --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
#     --build-arg NO_PROXY=${NO_PROXY} \
#     --build-arg http_proxy=${http_proxy} \
#     --build-arg https_proxy=${https_proxy} \
#     --build-arg no_proxy=${no_proxy} \
#     --build-arg TENSORFLOW_WHLS=${TENSORFLOW_WHLS_TEMP} \
#     -f dockerfiles/Dockerfile.ubuntu \
#     --tag ${TF_DOCKER_BUILD_IMAGE_NAME}:${UBUNTU_IMAGE_TAG} \
#     .

docker build \
    --build-arg HTTP_PROXY=${HTTP_PROXY} \
    --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
    --build-arg NO_PROXY=${NO_PROXY} \
    --build-arg http_proxy=${http_proxy} \
    --build-arg https_proxy=${https_proxy} \
    --build-arg no_proxy=${no_proxy} \
    --build-arg TENSORFLOW_WHLS=${TENSORFLOW_WHLS_TEMP} \
    -f dockerfiles/Dockerfile.debian \
    --tag ${TF_DOCKER_BUILD_IMAGE_NAME}:${DEBIAN_IMAGE_TAG} \
    .

# docker build \
#     --build-arg HTTP_PROXY=${HTTP_PROXY} \
#     --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
#     --build-arg NO_PROXY=${NO_PROXY} \
#     --build-arg http_proxy=${http_proxy} \
#     --build-arg https_proxy=${https_proxy} \
#     --build-arg no_proxy=${no_proxy} \
#     --build-arg TENSORFLOW_WHLS=${TENSORFLOW_WHLS_TEMP} \
#     -f dockerfiles/Dockerfile.centos \
#     --tag ${TF_DOCKER_BUILD_IMAGE_NAME}:${CENTOS_IMAGE_TAG} \
#     .

rm -rf ${TENSORFLOW_WHLS_TEMP}

set +xe
