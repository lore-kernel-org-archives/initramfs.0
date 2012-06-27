From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] Fixed BOOTIF for converting mac addr to lowercase
Date: Wed, 27 Jun 2012 11:29:13 +0530
Message-ID: <4FEAA131.3040304@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030301080307080308070205"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------030301080307080308070205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The patch, acfab373 - Handle upper case MAC addresses in ifname 
option,takes care of only the MAC conversion to lower case in the 
interface name.  But the same has to be taken care for BOOTIF also.  
This patch takes care of changing the BOOTIF to lower case.

Note that sed has been used in the patch instead of tr, as it is not 
compulsion to install tr by dracut in the initramfs and may not be 
available always.

Signed-off-by: Srinivasa T N (seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org)

--------------030301080307080308070205
Content-Type: text/plain;
 name="convert-mac-to-lower-net-genrules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="convert-mac-to-lower-net-genrules.patch"

From 2ec9c91adbf808dbad9bdd2057d9df55a62b711f Mon Sep 17 00:00:00 2001
From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Date: Wed, 27 Jun 2012 11:20:13 +0530
Subject: [PATCH] Fixed BOOTIF for converting mac addr to lowercase

---
 modules.d/40network/net-genrules.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 99d0fe5..b2f4fbf 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -10,7 +10,8 @@ fix_bootif() {
     macaddr=${macaddr%:}
     # strip hardware type field from pxelinux
     [ -n "${macaddr%??:??:??:??:??:??}" ] && macaddr=${macaddr#??:}
-    echo $macaddr
+    # return macaddr with lowercase alpha characters expected by udev
+    echo $macaddr | sed 'y/ABCDEF/abcdef/'
 }
 
 # Don't continue if we don't need network
-- 
1.7.4.4


--------------030301080307080308070205--
