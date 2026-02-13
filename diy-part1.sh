#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git timecontrol https://github.com/sirpdboy/luci-app-timecontrol' >>feeds.conf.default
# echo 'src-git taskplan https://github.com/sirpdboy/luci-app-taskplan' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# diy-part1.sh 新增内容
cd openwrt
# 应用 BBRv3 补丁到内核
if [ -f ../patches/kernel/bbr3-5.4.patch ]; then
    patch -p1 < ../patches/kernel/bbr3-5.4.patch
    echo "BBRv3 补丁已应用"
fi
