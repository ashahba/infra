#!/usr/bin/env bash

# Copyright 2020 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

python -c "from tensorflow.python.util import _pywrap_util_port; print('oneDNN optimizations enabled:', _pywrap_util_port.IsMklEnabled())"
onednn_enabled=$?

if [[ $onednn_enabled -eq 0 ]]; then
   echo "PASS: Intel® oneAPI Deep Neural Network Library(Intel® oneDNN) is enabled"
else
   die "FAIL: Intel® oneAPI Deep Neural Network Library(Intel® oneDNN) is not enabled"
fi
