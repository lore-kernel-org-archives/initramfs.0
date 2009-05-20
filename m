From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] LIBDIR detection without /proc
Date: Wed, 20 May 2009 16:22:31 -0400
Message-ID: <4A146687.3020508@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

bash-4.0# ./dracut -l -f /boot/initrd-2.6.29.3-140.fc11.i586.img 
2.6.29.3-140.fc11.i586
ldd: /proc/8072/exe: No such file or directory

modules.d/50plymouth/plymouth-populate-initrd

Could we please not rely on /proc to detect anything?  Something like 
the following would work fine.  It also has the benefit of being able to 
run without /proc mounted, which is great for building initrd's within a 
chroot.

diff --git a/modules.d/50plymouth/plymouth-populate-initrd 
b/modules.d/50plymouth/plymouth-populate-initrd
index df6e7c5..58b5b5a 100755
--- a/modules.d/50plymouth/plymouth-populate-initrd
+++ b/modules.d/50plymouth/plymouth-populate-initrd
@@ -1,5 +1,5 @@
  #!/bin/bash
-if ldd /proc/$$/exe |grep -q lib64; then
+if [ -f /usr/lib64/plymouth/text.so ]; then
      LIBDIR="/usr/lib64"
  else
      LIBDIR="/usr/lib"


Another issue, it appears this plymouth module is uncondtional? 
Shouldn't it skip plymouth install if it plymouth does not exist for the 
sake of other distributions?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
