From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: Re: [RFC] [PATCH] Bonding support for dracut
Date: Tue, 19 Oct 2010 16:54:29 +0300
Message-ID: <4CBDA315.2070603@hoster-ok.com>
References: <4CBC37E7.9010904@hoster-ok.com> <4CBC4661.3020100@redhat.com> <4CBC504A.7020002@hoster-ok.com> <4CBC566C.9080407@redhat.com> <4CBC5A48.1010304@hoster-ok.com> <4CBC5C7C.4000504@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070908000800080007000300"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CBC5C7C.4000504-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------070908000800080007000300
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

copy-paste typo fix is attached

Best,
Vladislav

--------------070908000800080007000300
Content-Type: text/x-patch;
 name="dracut-bonding-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-bonding-fix.patch"

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 968d9f0..45fcde2 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -50,7 +50,7 @@ for netif in $IFACES ; do
     } > /tmp/ifcfg/ifcfg-$netif
 
     # bridge needs different things written to ifcfg
-    if [ -z "$bridge" ] && if [ -z "$bond" ]; then
+    if [ -z "$bridge" ] && [ -z "$bond" ]; then
         # standard interface
         {
             echo "HWADDR=$(cat /sys/class/net/$netif/address)"

--------------070908000800080007000300--
