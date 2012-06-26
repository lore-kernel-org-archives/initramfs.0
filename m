From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/1] Convert MAC in BOOTIF parameter to lower case
Date: Wed, 27 Jun 2012 00:04:36 +0530
Message-ID: <4FEA00BC.8090505@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000805080706090200010502"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------000805080706090200010502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The patch at http://comments.gmane.org/gmane.linux.kernel.initramfs/2244 
takes care of only the MAC conversion to lower case in the interface 
name.  But the same has to be taken care for BOOTIF also.  This patch 
takes care of changing the BOOTIF to lower case.

Note that sed has been used instead of tr, as dracut does not install tr 
to the initramfs, atleast on RHEL 6.x.

Signed-off-by: Srinivasa T N (seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org)


--------------000805080706090200010502
Content-Type: text/plain;
 name="convert-mac-to-lower-net-genrules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="convert-mac-to-lower-net-genrules.patch"

diff -rNu a/dracut-004/modules.d/40network/net-genrules.sh b/dracut-004/modules.d/40network/net-genrules.sh
--- a/dracut-004/modules.d/40network/net-genrules.sh	2012-06-26 21:51:37.835027611 +0530
+++ b/dracut-004/modules.d/40network/net-genrules.sh	2012-06-25 14:21:02.905652291 +0530
@@ -10,7 +10,8 @@
     macaddr=${macaddr%:}
     # strip hardware type field from pxelinux
     [ -n "${macaddr%??:??:??:??:??:??}" ] && macaddr=${macaddr#??:}
-    echo $macaddr
+    # return macaddr with lowercase alpha characters expected by udev
+    echo $macaddr | sed 'y/ABCDEF/abcdef/'
 }
 
 # Don't continue if we don't need network

--------------000805080706090200010502--
