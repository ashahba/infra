# Build TensorFlow wheels from source
The script `build_tf_wheels.sh` provides an easy way to build the wheels for a given version of TensorFlow.

This script takes several input parameters but only a few should be modified by end users.
- `PY_VERSION`: The version of the wheel to be build. Currently 3.7, 3.8 or 3.9 are supported.
Please keep in mind that depending on which OS will be used to install the Wheel on, this parameter
should be set properly.
- `TF_DOCKER_BUILD_DEVEL_BRANCH`: TensorFlow branch/commit to be used for building the wheel
- `TF_BUILD_VERSION`: TensorFlow branch/commit to be used for building the wheel
- `TF_REPO`: Git repository used for clonning TensorFlow
- `BUILD_CLX_CONTAINERS`: Enable `AVX512 with VNNI support` flag during the build
- `BUILD_ICX_SERVER_CONTAINERS`: Build with flags suited for installing the wheel on an ICE Lake Server

```bash
export ROOT_CONTAINER=tensorflow/build
export PY_VERSION=${PY_VERSION:-3.9}
export ROOT_CONTAINER_TAG=latest-python${PY_VERSION} 

# TF_BUILD_VERSION can be either a tag, branch, commit ID or PR number.
# For a PR, set TF_BUILD_VERSION_IS_PR="yes"
export TF_DOCKER_BUILD_DEVEL_BRANCH=${TF_DOCKER_BUILD_DEVEL_BRANCH:-master}
export TF_BUILD_VERSION=${TF_DOCKER_BUILD_DEVEL_BRANCH:-master}
export TF_DOCKER_BUILD_DEVEL_BRANCH_IS_PR=${TF_DOCKER_BUILD_DEVEL_BRANCH_IS_PR:-no}
export TF_BUILD_VERSION_IS_PR=${TF_DOCKER_BUILD_DEVEL_BRANCH_IS_PR:-no}
export TF_REPO=${TF_REPO:-https://github.com/tensorflow/tensorflow}
export TF_DOCKER_BUILD_IMAGE_NAME=${TF_DOCKER_BUILD_IMAGE_NAME:-bitnami/intel-optimized-tensorflow}
export FINAL_IMAGE_NAME=${TF_DOCKER_BUILD_IMAGE_NAME:-intel-mkl/tensorflow}
export TF_DOCKER_BUILD_VERSION=${TF_DOCKER_BUILD_VERSION:-nightly}
export BUILD_AVX_CONTAINERS=${BUILD_AVX_CONTAINERS:-no}
export BUILD_AVX2_CONTAINERS=${BUILD_AVX2_CONTAINERS:-no}
export BUILD_SKX_CONTAINERS=${BUILD_SKX_CONTAINERS:-no}
export BUILD_CLX_CONTAINERS=${BUILD_CLX_CONTAINERS:-no}
export BUILD_ICX_CLIENT_CONTAINERS=${BUILD_ICX_CLIENT_CONTAINERS:-no}
export BUILD_ICX_SERVER_CONTAINERS=${BUILD_ICX_SERVER_CONTAINERS:-yes}
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
```

Once the script is run, a container like below for example is created:
```
bitnami/intel-optimized-tensorflow:nightly-avx512-devel-mkl
```
and the wheels will be stored at: `tensorflow_whls/<TF_BUILD_VERSION>.

# Build TensorFlow Containers with the wheels from previous steps pre-installed
The script `build_tf_containers.sh` provides a reference an easy way to build the containers.

There are currently 3 Dockerfiles provided.
Please keep in mind that `CentOS 8` and `Ubuntu 20.04` container build commands are commented out,
because prior to doing so, the right version of wheel need to be created first.
