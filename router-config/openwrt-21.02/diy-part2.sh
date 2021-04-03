#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic S9xxx STB
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Copyright (C) 2020 https://github.com/P3TERX/Actions-OpenWrt
# Copyright (C) 2020 https://github.com/ophub/amlogic-s9xxx-openwrt
#========================================================================================================================

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root::0:0:99999:7:::/root:$1$OuDXvtVj$kuiJ2eldOpPTeBEj9Ot.E0:18720:0:99999:7:::/g' package/base-files/files/etc/shadow

# Add branches package
svn co https://github.com/Lienol/openwrt/branches/21.02/package/{lean,default-settings} package
svn co https://github.com/xiaorouji/openwrt-passwall/trunk package/openwrt-passwall

# other branches package
# svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/{lean,lienol} package
# svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/libs/libdouble-conversion feeds/packages/libs/libdouble-conversion
# svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/nps feeds/packages/net/nps
# sed -i '/banner/d' package/lean/default-settings/Makefile
# sed -i '/banner/d' package/lean/default-settings/files/zzz-default-settings
# sed -i '/Source Code/d' package/lean/autocore/files/arm/rpcd_10_system.js
# sed -i 's/cpuusage.cpuusage,/cpuusage.cpuusage/g' package/lean/autocore/files/arm/rpcd_10_system.js

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages
# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Apply patch
# git apply ../router-config/patches/{0001*,0002*}.patch --directory=feeds/luci

# Modify some code adaptation
# sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Mydiy luci-app and luci-theme（use to /.config luci-app&theme）
# ==========luci-app-url==========
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
# ==========luci-theme-url==========
# svn co https://github.com/Lienol/openwrt-package/trunk/lienol/luci-theme-bootstrap-mod package/luci-theme-bootstrap-mod

$GITHUB_WORKSPACE/router-config/openwrt-21.02/zh-cn.sh
