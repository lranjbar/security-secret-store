#!/bin/bash
#  ----------------------------------------------------------------------------------
#  vault-unseal-cmd.sh version 1.0 created February 13, 2018
#
#  @author:  Alain Pulluelo, ForgeRock
#  @email:   alain.pulluelo@forgerock.com
#  @address: 201 Mission St, Suite 2900
#            San Francisco, CA 94105, USA
#  @phone:   +1(415)-559-1100
#
#  Copyright (c) 2018, ForgeRock
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#  ----------------------------------------------------------------------------------

source vault-cmd-global.env

if [[ $# != 1 ]]; then
        echo "+++ SYNTAX ERROR"
        usage "<vault-server-container-id (s1|s2)>"
        exit
fi

if [[ ($1 != "s1") && ($1 != "s2") ]]; then
        echo "+++ SYNTAX ERROR: Invalid Vault Server Id (s1|s2)"
        usage "<vault-server-container-id (s1|s2)>"
        exit
fi

vault_container="myvault-$1"

# Get the Unseal Keys:
k1=$(cat ${_CURRENT_INIT_ASSETS} | jq -r '.unseal_keys_b64 | .[0]')
k2=$(cat ${_CURRENT_INIT_ASSETS} | jq -r '.unseal_keys_b64 | .[1]')
k3=$(cat ${_CURRENT_INIT_ASSETS} | jq -r '.unseal_keys_b64 | .[2]')
k4=$(cat ${_CURRENT_INIT_ASSETS} | jq -r '.unseal_keys_b64 | .[3]')
k5=$(cat ${_CURRENT_INIT_ASSETS} | jq -r '.unseal_keys_b64 | .[4]')

# Unseal the Vault server (Unseal Quorum is 3/5)
echo "+++ ${vault_container} unsealing process..."
echo ""
docker exec -it ${vault_container} vault operator unseal ${_TLS} $k1
echo ""
docker exec -it ${vault_container} vault operator unseal ${_TLS} $k3
echo ""
docker exec -it ${vault_container} vault operator unseal ${_TLS} $k5
echo ""

exit

#EOF
