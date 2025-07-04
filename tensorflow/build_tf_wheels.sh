#!/usr/bin/env bash

# upon completion of this command there will be a TensorFlow wheel located under: /tmp/pip3 
# and within the container:  bitnami/intel-optimized-tensorflow

set -xe

source ./common_env.sh

export ROOT_CONTAINER=tensorflow/build
export ROOT_CONTAINER_TAG=latest-python${PY_VERSION} 

# TF_BUILD_VERSION can be either a tag, branch, commit ID or PR number.
# For a PR, set TF_BUILD_VERSION_IS_PR="yes"
export TF_DOCKER_BUILD_DEVEL_BRANCH_IS_PR=${TF_DOCKER_BUILD_DEVEL_BRANCH_IS_PR:-no}
export TF_BUILD_VERSION_IS_PR=${TF_DOCKER_BUILD_DEVEL_BRANCH_IS_PR:-no}
export TF_REPO=${TF_REPO:-https://github.com/tensorflow/tensorflow}
export FINAL_IMAGE_NAME=${TF_DOCKER_BUILD_IMAGE_NAME:-intel-mkl/tensorflow}
export TF_DOCKER_BUILD_VERSION=${TF_DOCKER_BUILD_VERSION:-nightly}
export CONTAINER_PORT=${CONTAINER_PORT:-8888}
export BUILD_TF_V2_CONTAINERS=${BUILD_TF_V2_CONTAINERS:-yes}
export BUILD_TF_BFLOAT16_CONTAINERS=${BUILD_TF_BFLOAT16_CONTAINERS:-no}
export ENABLE_SECURE_BUILD=${ENABLE_SECURE_BUILD:-yes}
# export BAZEL_VERSION=${BAZEL_VERSION:-3.7.2}
export BUILD_PY2_CONTAINERS=${BUILD_PY2_CONTAINERS:-no}
export ENABLE_DNNL1=${ENABLE_DNNL1:-no}
export ENABLE_HOROVOD=${ENABLE_HOROVOD:-no}
export INSTALL_HOROVOD_FROM_COMMIT=${INSTALL_HOROVOD_FROM_COMMIT:-no}
export ENABLE_GCC8=${ENABLE_GCC8:-no}
export OPENMPI_VERSION=${OPENMPI_VERSION}
export OPENMPI_DOWNLOAD_URL=${OPENMPI_DOWNLOAD_URL}
export HOROVOD_VERSION=${HOROVOD_VERSION}
export BUILD_SSH=${BUILD_SSH:-no}
export IS_NIGHTLY=${IS_NIGHTLY:-no}
export RELEASE_CONTAINER=${RELEASE_CONTAINER:-no}

git clone --single-branch --branch=${TF_BUILD_VERSION} ${TF_REPO} ${TENSORFLOW_SRCS}/${TF_DOCKER_BUILD_DEVEL_BRANCH}

export BAZEL_VERSION=$(head -n 1 tensorflow/.bazelversion)

pushd ${TENSORFLOW_SRCS}/${TF_DOCKER_BUILD_DEVEL_BRANCH}/tensorflow/tools/ci_build/linux/mkl

./build-dev-container.sh
popd

TEMP_CONTAINER_NAME="temp-intel-devel-mkl"
docker run --name ${TEMP_CONTAINER_NAME} ${TF_DOCKER_BUILD_IMAGE_NAME}:${TF_DOCKER_BUILD_VERSION}-icx-server-devel-mkl /bin/true
docker cp ${TEMP_CONTAINER_NAME}:/tmp/pip3 ${TENSORFLOW_WHLS}
docker rm -f ${TEMP_CONTAINER_NAME}

echo "TensorFlow wheel has been successfully built and saved at: ${TENSORFLOW_WHLS}/pip3"

set +xe
