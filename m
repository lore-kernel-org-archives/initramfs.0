From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 2/3] Remove netroot check in cmdline parsing code
Date: Mon, 21 May 2012 17:14:45 +0800
Message-ID: <1337591686-31875-2-git-send-email-amwang@redhat.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337591686-31875-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Relax the rules for kdump, we don't specify netroot in kdump.

Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/40network/parse-bond.sh   |    3 ---
 modules.d/40network/parse-bridge.sh |    3 ---
 modules.d/40network/parse-vlan.sh   |    3 ---
 3 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/modules.d/40network/parse-bond.sh b/modules.d/40network/parse-bond.sh
index 0a4c006..c7bbc63 100755
--- a/modules.d/40network/parse-bond.sh
+++ b/modules.d/40network/parse-bond.sh
@@ -15,9 +15,6 @@
 
 # Check if bond parameter is valid
 if getarg bond= >/dev/null ; then
-    if [ -z "$netroot" ] ; then
-        die "No netboot configured, bond is invalid"
-    fi
     command -v brctl >/dev/null 2>&1 || die "No 'brctl' installed"
 fi
 
diff --git a/modules.d/40network/parse-bridge.sh b/modules.d/40network/parse-bridge.sh
index aaa5a54..6e1fee1 100755
--- a/modules.d/40network/parse-bridge.sh
+++ b/modules.d/40network/parse-bridge.sh
@@ -13,9 +13,6 @@
 
 # Check if bridge parameter is valid
 if getarg bridge= >/dev/null ; then
-    if [ -z "$netroot" ] ; then
-        die "No netboot configured, bridge is invalid"
-    fi
     command -v brctl >/dev/null 2>&1 || die "No 'brctl' installed" 
 fi
 
diff --git a/modules.d/40network/parse-vlan.sh b/modules.d/40network/parse-vlan.sh
index efe7bfa..a99c858 100644
--- a/modules.d/40network/parse-vlan.sh
+++ b/modules.d/40network/parse-vlan.sh
@@ -9,9 +9,6 @@
 
 # Check if vlan parameter is valid
 if getarg vlan= >/dev/null ; then
-    if [ -z "$netroot" ] ; then
-        die "No netboot configured, vlan is invalid"
-    fi
     command -v vconfig >/dev/null 2>&1 || die "No 'vconfig' installed"
 fi
 
-- 
1.7.7.6
