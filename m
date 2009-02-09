From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:12 -0800 (PST)
Message-ID: <a80295e855ca513aa298096b00807a1429961638.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=xc+GbkG1VzwnHT7ST5S12IyoKRWI+Xw3JXyHnPdHZH0=;
        b=UC7p05aXBs6lT+h3xKCFlX8u05q1TvcMnOWghnT7nxkUUdjgLdmuhkwWlWi5ebqMbl
         S7DHWbZ91bREw7qugPz6EdeVGJciIsqDTahw4vqEK1ShfS9ZZs9KGTrJHAwXxMrnBTsV
         VwfuKHmlCrakO35CO2YynVlZlGI19FYyqFSIo=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Don't load commands into the initrd that are built in to bash.

No sense in loading commands that will never be used.
---
 dracut |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index ef2ca42..0fe0282 100755
--- a/dracut
+++ b/dracut
@@ -4,6 +4,7 @@
 # Tries to retain some degree of compatibility with the command line
 # of the various mkinitrd implementations out there
 #
+
 # Copyright 2008, Red Hat, Inc.  Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 # GPLv2 header here
 
@@ -66,7 +67,7 @@ fi
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 
 # executables that we have to have
-exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /bin/kill /sbin/pidof /bin/sleep /bin/echo /usr/sbin/chroot"
+exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot"
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
 # and some things that are nice for debugging
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
