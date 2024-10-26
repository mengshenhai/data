#!/bin/bash

# 定义centosrepo源函数
function centosrepo(){
	# 备份主repo源
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

	# 询问需要安装的版本
	read -p "请问您的系统版本为[ 6 | 7 | 8]：" version

	# 根据获取的版本判断进行安装
	case $version in
		"6")
			curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-6.10.repo
		;;
		"7")
			curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
		;;
		"8")
			curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
		;;
		*)
			echo -e "\e[91m请输入正确的版本号：[ 6 | 7 | 8 ]\e[0m"
			exit
		;;
	esac

	# 安装wget命令
	yum -y install wget

	# 备份epel源
	mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
	mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup

	# 下载epel源
	wget -O /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo

	# 生成缓存
	yum makecache

	# 返回程序结果
	echo -e "\e[92m您的centos$version版本的阿里云源及epel源已更换完成\e[0m"
}

# 判断网络并执行安装
ping -c1 223.5.5.5 
if [ $? -eq 0 ]; then
	centosrepo
else
    	echo -e "\e[91m您的网络存在问题，请检查您的网络\e[0m"
fi
