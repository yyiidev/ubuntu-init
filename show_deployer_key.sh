CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${CURRENT_DIR}/common.sh

check_root

echo ""
sudo -H -u ${DEPLOYER_USER} sh -c 'cat ~/.ssh/id_rsa.pub'
echo ""