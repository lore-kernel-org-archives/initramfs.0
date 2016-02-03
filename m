From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] network/net-lib.sh: fix "ip=" mac address parsing
Date: Wed,  3 Feb 2016 16:44:52 +0800
Message-ID: <1454489092-32472-1-git-send-email-xlpang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Firstly, in order to make things clear, mac address like
ipv6 address which contains ":" should be embraced with"[]".
Actually if we don't embraced mac address with "[]", the
following format of "ip=" with macaddr will be parsed wrongly:
"ip=<interface>:{dhcp|on|any|dhcp6|auto6}[:[<mtu>][:<macaddr>]]"
so we'd better do it this way.

As a result, the following format of "ip=" command:
"ip=<client-IP>:[<peer>]:<gateway-IP>:<netmask>:<client_hostname>:
<interface>:{none|off|dhcp|on|any|dhcp6|auto6|ibft}:[:[<mtu>][:<macaddr>]]"

like "ip=:::::enp0s25:dhcp:1500:[50:7b:9d:20:df:20]" will
be parsed wrongly by ip_to_var() for its mac address.

So fix it by directly assigning "$9" to "macaddr".

Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-lib.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 31f1a56..1e2c5bf 100755
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -427,14 +427,10 @@ ip_to_var() {
                     ;;
                 [0-9]*)
                     mtu="$8"
-                    if [ -n "${9}" -a -n "${10}" -a -n "${11}" -a -n "${12}" -a -n "${13}" -a -n "${14}" ]; then
-                        macaddr="${9}:${10}:${11}:${12}:${13}:${14}"
-                    fi
+                    [ -n $9 ] && macaddr=$9
                     ;;
                 *)
-                    if [ -n "${9}" -a -n "${10}" -a -n "${11}" -a -n "${12}" -a -n "${13}" -a -n "${14}" ]; then
-                        macaddr="${9}:${10}:${11}:${12}:${13}:${14}"
-                    fi
+                    [ -n $9 ] && macaddr=$9
                     ;;
             esac
             ;;
-- 
1.8.3.1
