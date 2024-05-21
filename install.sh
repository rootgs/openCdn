# 安装脚本
# !/bin/bash

# 检测操作系统版本是否为 Ubuntu 20.04 或 22.04
OS_VERSION=$(lsb_release -d | awk -F " " '{print $2}')

if [ "$OS_VERSION" != "20.04" ] && [ "$OS_VERSION" != "22.04" ]; then
    echo "操作系统版本不符合要求，需要 Ubuntu 20.04 或 22.04"
    exit 1
fi

# 检测内存和 CPU 核心数
TOTAL_MEMORY=$(free -m | awk '/^Mem:/{print $2}')
TOTAL_CORES=$(nproc)

if [ $TOTAL_MEMORY -lt 4096 ]; then
    echo "系统内存不足 4GB，请确保服务器配置满足要求"
    exit 1
fi

if [ $TOTAL_CORES -lt 4 ]; then
    echo "CPU 核心数少于 4 个，请确保服务器配置满足要求"
    exit 1
fi

# 检测 /home 目录空间
HOME_DIRECTORY="/home"
HOME_SPACE=$(df -h $HOME_DIRECTORY | awk 'NR==2{print $4}')
MIN_HOME_SPACE="100G"

if [ ${HOME_SPACE%G} -lt ${MIN_HOME_SPACE%G} ]; then
    echo "/home 目录空间少于 100GB，请确保服务器配置满足要求"
    exit 1
fi

echo "系统环境符合要求，可以继续安装"
