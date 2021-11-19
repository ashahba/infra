# Build TensorFlow wheels from source
The script `build_tf_wheels.sh` provides an easy way to build the wheels for a given version of TensorFlow.

This script takes several input parameters but only a few should be modified by end users, which are
collected in `common_env.sh` script:
- `PY_VERSION`: The version of the wheel to be build. Currently 3.7, 3.8 or 3.9 are supported.
Please keep in mind that depending on which OS will be used to install the Wheel on, this parameter
should be set properly.
- `TF_DOCKER_BUILD_DEVEL_BRANCH`: TensorFlow branch/commit to be used for building the wheel
- `TF_BUILD_VERSION`: TensorFlow branch/commit to be used for building the wheel
- `TF_REPO`: Git repository used for clonning TensorFlow
- `BUILD_CLX_CONTAINERS`: Enable `AVX512 with VNNI support` flag during the build
- `BUILD_ICX_SERVER_CONTAINERS`: Build with flags suited for installing the wheel on an ICE Lake Server

Once the script is run, a container like below for example is created:
```
bitnami/intel-optimized-tensorflow:nightly-avx512-devel-mkl
```
and the wheels will be stored at: `tensorflow_whls/<TF_BUILD_VERSION>/python<PY_VERSION>.

# Build TensorFlow Containers with the wheels from previous steps pre-installed
The script `build_tf_containers.sh` provides a reference an easy way to build the containers.
Again most parameters should be left intact. Please also note that some parameters are delivered through
`common_env.sh` script.

There are currently 3 Dockerfiles provided.
Please keep in mind that `CentOS 8` and `Ubuntu 20.04` container build commands are commented out,
because prior to doing so, the right version of wheel need to be created first.

Once the script is run, a container like below is created that contains the above wheel pre-installed.
```
bitnami/intel-optimized-tensorflow   master-avx512-debian   6c3b1c8feff0   7 minutes ago   1.37GB
``` 

# Test the wheel and container
Once the container is build, you can run the following command to test if Intel® oneDNN is present:
```
$ docker run --rm bitnami/intel-optimized-tensorflow:master-avx512-debian /bin/bash "import-onednn.sh"
oneDNN optimizations enabled: True
PASS: Intel® oneAPI Deep Neural Network Library(Intel® oneDNN) is enabled
```
