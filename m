From: Alexander Lakhin <a.lahin-QLx1KmmFfsSQHXbzqtDRaA@public.gmane.org>
Subject: Dracut is not processing last line of a kernel modules configuration
 file
Date: Fri, 26 Dec 2014 15:55:06 +0300
Message-ID: <549D5AAA.8050408@ntcit-rosa.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020005040609060501010509"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------020005040609060501010509
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've found that dracut skips a kernel module if it's specified in 
/etc/modules-load.d/<module>.conf in a single line without EOL.
For example, when /etc/modules-load.d/krb5.conf contains the single line:
rpcsec_gss_krb5
(without end-of-line), I've got the error:
systemd-modules-load[]: Failed to find module 'rpcsec_gss_krb5'

and lsinitrd shows no such module in the initrd image.

Attached patch fixes the issue.

Best regards,
Alexander

--------------020005040609060501010509
Content-Type: text/x-patch;
 name="dracut-037-process-last-line-of-mod.conf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-037-process-last-line-of-mod.conf.patch"

diff -ru dracut-037/modules.d/98systemd/module-setup.sh dracut-037.new/modules.d/98systemd/module-setup.sh
--- dracut-037/modules.d/98systemd/module-setup.sh	2014-03-19 20:16:08.000000000 +0400
+++ dracut-037.new/modules.d/98systemd/module-setup.sh	2014-12-10 17:14:06.779593964 +0300
@@ -132,7 +132,8 @@
         local _line i
         for i in "$1"/*.conf; do
             [[ -f $i ]] || continue
-            while read _line; do
+            EOF=false; until $EOF ; do
+                read _line || EOF=true
                 case $_line in
                     \#*)
                         ;;

--------------020005040609060501010509--
