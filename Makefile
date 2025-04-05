#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=caddy
PKG_VERSION:=20250405
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/caddyserver/caddy.git
PKG_SOURCE_DATE:=2025-04-05
PKG_SOURCE_VERSION:=5a6b2f8d1d4633622b551357f3cc9d27ec669d02
PKG_MIRROR_HASH:=1d746c016988ade7d1e659d35f57f7a0d77875176017275af95d32e7e390c03b

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host upx/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/caddyserver/caddy/v2/cmd
GO_PKG_BUILD_PKG:=$(GO_PKG)/caddy
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:=github.com/caddyserver/caddy/v2.CustomVersion=v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
  TITLE:=Caddy is an open source web server
  URL:=https://caddyserver.com
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  DEPENDS:=$(GO_ARCH_DEPENDS) +libpthread
endef

define Package/$(PKG_NAME)/description
Caddy is an extensible server platform that uses TLS by default.
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/caddy
endef

define Package/caddy/install
	$(call GoPackage/Package/Install/Bin,$(1))
endef

$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
