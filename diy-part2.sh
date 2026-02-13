#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
#!/bin/bash
# diy-part2.sh - 自定义编译配置，添加 BBRv3 支持

# 切换到 OpenWrt 源码目录
cd "$(dirname $0)/openwrt" || exit 1

# 启用 BBRv3 相关内核选项
# 1. 启用 TCP BBRv3 拥塞控制算法
echo 'CONFIG_KERNEL_TCP_CONG_BBR3=y' >> .config
# 2. 启用必要的依赖选项（确保 BBRv3 能正常工作）
echo 'CONFIG_KERNEL_TCP_CONG_ADVANCED=y' >> .config
echo 'CONFIG_KERNEL_NET_SCHED=y' >> .config
echo 'CONFIG_KERNEL_NET_CLS_ACT=y' >> .config
echo 'CONFIG_KERNEL_NET_ACT_POLICE=y' >> .config

# 如果需要将 BBRv3 设置为默认拥塞控制算法，添加以下配置
# echo 'CONFIG_KERNEL_DEFAULT_TCP_CONG="bbr3"' >> .config

# 清理重复配置并更新 .config
./scripts/config -u CONFIG_KERNEL_TCP_CONG_BBR
./scripts/config -e CONFIG_KERNEL_TCP_CONG_BBR3
make defconfig
