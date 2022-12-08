# WGET COM AGENT DA VIRGINIAcat
DISTRO=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
UBUNTU="Ubuntu"
CENTOS="CentOS Linux"
AMAZON="Amazon Linux"
if [[ $DISTRO == $UBUNTU ]]; then
  # DOWNLOAD DO AGENT
  wget https://s3.us-east-1.amazonaws.com/amazoncloudwatch-agent-us-east-1/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb 
  # INSTALACAO DO AGENT
  dpkg -i -E ./amazon-cloudwatch-agent.deb
elif [[ $DISTRO == $CENTOS ]]; then
  # DOWNLOAD DO AGENT
  wget https://s3.amazonaws.com/amazoncloudwatch-agent/centos/amd64/latest/amazon-cloudwatch-agent.rpm
  # INSTALACAO DO AGENT
  rpm -ivh amazon-cloudwatch-agent.rpm
else
  # DOWNLOAD DO AGENT
  https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
  # INSTALACAO DO AGENT
  rpm -ivh amazon-cloudwatch-agent.rpm
fi
cd /opt/aws/amazon-cloudwatch-agent/bin 
# BAIXAR SCRIPT DE COLETA (BASICO) PARA LINUX
wget https://raw.githubusercontent.com/aldeiacloud/cloudwatch_ubuntu18/main/config.json 
cd /opt/aws/amazon-cloudwatch-agent/etc/ 
cp -av ../bin/config.json amazon-cloudwatch-agent.json 
mkdir -p /usr/share/collectd/ 
touch /usr/share/collectd/types.db 
sudo sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s 
systemctl enable amazon-cloudwatch-agent 
systemctl status amazon-cloudwatch-agent
