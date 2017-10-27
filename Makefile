#OpenWrt Makefile
include $(TOPDIR)/rules.mk

PKG_NAME:=sidmat
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/sidmat-$(PKG_VERSION)
PKG_SOURCE:=master.zip
PKG_SOURCE_URL:=https://github.com/acabrol/sidmat/archive/master.zip
PKG_MD5SUM:=669a573702cba84803bf7e4b2ba60c07
PKG_CAT:=unzip
MAKE_PATH:=src

include $(INCLUDE_DIR)/package.mk

define Package/sidmat
  SECTION:=base
  CATEGORY:=Network
  DEPENDS:=+libpcap
  TITLE:=Simple DNS matcher
  #DESCRIPTION:=This variable is obsolete. use the Package/name/description define instead!
  URL:=https://github.com/acabrol/sidmat
endef

define Package/sidmat/description
sidmat scans DNS traffic. If domain name in DNS server response matches given regex, resolved address (from A record) printed to stdout.

It can be useful for "domain filtering" or other operations when you need to use domain names instead of IP-addresses.

sidmat can use pcap or nflog (under Linux) for packet capture.
endef

define Build/Configure
  $(call Build/Configure/Default,--with-linux-headers=$(LINUX_DIR))
endef

define Package/bridge/install
        $(INSTALL_DIR) $(1)/usr/sbin
        $(INSTALL_BIN) $(PKG_BUILD_DIR)/sidmat/sidmat $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,bridge))
