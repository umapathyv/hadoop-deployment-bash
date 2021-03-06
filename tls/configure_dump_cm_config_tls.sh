#!/bin/bash
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
#
# Copyright Clairvoyant 2017

CMHOST=localhost
CMPORT=7180
CMPORTTLS=7183

echo "********************************************************************************"
echo "*** $(basename "$0")"
echo "********************************************************************************"
echo "Configuring dump_cm_config.sh for TLS..."
if ! (exec 6<>/dev/tcp/${CMHOST}/${CMPORT}); then
  echo 'ERROR: cloudera-scm-server not listening...'
  exit 1
fi

if ! (exec 6<>/dev/tcp/${CMHOST}/${CMPORTTLS}); then
  echo 'ERROR: cloudera-scm-server TLS not listening...'
  exit 2
fi

sed -e "/^CMHOST=/s|=.*|=${CMHOST}|" \
    -e "/^CMPORT=/s|=.*|=${CMPORTTLS}|" \
    -i /usr/local/sbin/dump_cm_config.sh

/usr/local/sbin/dump_cm_config.sh >/var/log/cm_config.dump

