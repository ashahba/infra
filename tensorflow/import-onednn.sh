#!/usr/bin/env bash

python -c "from tensorflow.python.util import _pywrap_util_port; print('oneDNN optimizations enabled:', _pywrap_util_port.IsMklEnabled())"
onednn_enabled=$?

if [[ $onednn_enabled -eq 0 ]]; then
   echo "PASS: Intel® oneAPI Deep Neural Network Library(Intel® oneDNN) is enabled"
else
   die "FAIL: Intel® oneAPI Deep Neural Network Library(Intel® oneDNN) is not enabled"
fi
