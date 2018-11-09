#!/usr/bin/env bash

###############################################################################
# Copyright 2018 The Apollo Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

# Fail on first error.
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

wget https://www.coin-or.org/download/source/ADOL-C/ADOL-C-2.6.3.zip -O ADOL-C-2.6.3.zip
unzip ADOL-C-2.6.3.zip

pushd ADOL-C-2.6.3
./configure --prefix="/apollo/docker/build/installers/ADOL-C-2.6.3" ADD_CXXFLAGS="-fPIC" ADD_CFLAGS="-fPIC" ADD_FFLAGS="-fPIC"

make -j8 all
make install
mkdir -p /usr/local/adolc
cp -r include /usr/local/adolc/ && cp -r lib64 /usr/local/adolc/
popd

export LD_LIBRARY_PATH=/usr/local/adolc/lib64

# Clean up.
rm -fr ADOL-C-2.6.3.zip ADOL-C-2.6.3