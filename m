From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH 2/2] do not umount selinuxfs and sysfs
Date: Mon, 02 Jan 2017 02:26:31 +0100
Message-ID: <1483320391.2481.4.camel@trentalancia.net>
References: <1483319729.2481.2.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483319729.2481.2.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Do not umount the SELinux filesystem after loading the SELinux
policy.

 modules.d/98selinux/selinux-loadpolicy.sh |    2 --
 1 file changed, 2 deletions(-)

--- dracut-044-orig/modules.d/98selinux/selinux-loadpolicy.sh	2017-01-02 02:09:25.774143396 +0100
+++ dracut-044/modules.d/98selinux/selinux-loadpolicy.sh	2017-01-02 02:09:38.844621886 +0100
@@ -32,8 +32,6 @@ rd_load_policy()
             ret=$?
             info $out
         fi
-        umount /sys/fs/selinux
-        umount /sys
 
         if [ "$SELINUX" = "disabled" ]; then
             return 0;
