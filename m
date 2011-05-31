From: <haruo.tomita-g3qfMnKXm6lL9jVzuh4AOg@public.gmane.org>
Subject: (PATCH) force LANG=C for selinux load policy
Date: Tue, 31 May 2011 08:19:12 +0000
Message-ID: <4915AF3239D2024A92BCEC8BDAC566CE0116FA8A@TGXML315.toshiba.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: ja-JP
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Harold,

Using Japanese ja_JP.UTF-8 environment, 
the characters in load selinux policy message are garbled.
This simple patch mainly adds force LANG=C to selinux load policy.

Kind regards,
Haruo.

--- dracut-010/modules.d/98selinux/selinux-loadpolicy.sh.orig   2011-05-31 14:36:34.000000000 +0900
+++ dracut-010/modules.d/98selinux/selinux-loadpolicy.sh        2011-05-31 14:38:44.000000000 +0900
@@ -4,6 +4,11 @@

 # FIXME: load selinux policy.  this should really be done after we switchroot

+# We can't Japanese on normal console at boot time, so force LANG=C.
+if [ "$LANG" = "ja_JP.UTF-8" ]; then
+    LANG=C
+fi
+
 rd_load_policy()
 {
     # If SELinux is disabled exit now--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
