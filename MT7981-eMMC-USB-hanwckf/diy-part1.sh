#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 移除要替换的包
rm -rf package/emortal/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/emortal/luci-app-lucky

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
sed -i "/helloworld/d" "feeds.conf.default"

# Add a feed source
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
git clone https://github.com/sbwml/luci-app-openlist2 package/openlist2
git clone https://github.com/lgs2007m/luci-app-easytier package/easytier
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git_sparse_clone dev https://github.com/vernesong/OpenClash luci-app-openclash
git clone --depth=1 https://github.com/laipeng668/luci-app-gecoosac package/luci-app-gecoosac
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/lucky
