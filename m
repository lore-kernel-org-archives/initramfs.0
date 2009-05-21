From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Check /sbin/plymouthd for arch instead of /proc/$$/exe.
Date: Wed, 20 May 2009 20:37:55 -0400
Message-ID: <4A14A263.6000902@redhat.com>
References: <4A146687.3020508@redhat.com> <Pine.LNX.4.58.0905202249560.7805@gate.bb.dicp.net> <4A146EBF.5060404@redhat.com> <Pine.LNX.4.58.0905202309060.7805@gate.bb.dicp.net> <4A147DF3.4070108@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A147DF3.4070108-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here is an improved version of this patch.  /sbin/plymouthd is guaranteed to exist if it passed the check, and it would be of the correct architecture.

 From 6d1b465555ac4511b9bda90b7d72c29060c66955 Mon Sep 17 00:00:00 2001
From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 20 May 2009 20:35:08 -0400
Subject: [PATCH] Check /sbin/plymouthd for arch instead of /proc/$$/exe.
  /sbin/plymouthd is guaranteed to be there and be the correct arch.

---
  .../50plymouth-pre0.7/plymouth-populate-initrd     |    2 +-
  modules.d/50plymouth/plymouth-populate-initrd      |    2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/50plymouth-pre0.7/plymouth-populate-initrd b/modules.d/50plymouth-pre0.7/plymouth-populate-initrd
index e195ddc..1802b25 100755
--- a/modules.d/50plymouth-pre0.7/plymouth-populate-initrd
+++ b/modules.d/50plymouth-pre0.7/plymouth-populate-initrd
@@ -1,5 +1,5 @@
  #!/bin/bash
-if ldd /proc/$$/exe |grep -q lib64; then
+if ldd /sbin/plymouthd |grep -q lib64; then
      LIBDIR="/usr/lib64"
  else
      LIBDIR="/usr/lib"
diff --git a/modules.d/50plymouth/plymouth-populate-initrd b/modules.d/50plymouth/plymouth-populate-initrd
index df6e7c5..f3c67f1 100755
--- a/modules.d/50plymouth/plymouth-populate-initrd
+++ b/modules.d/50plymouth/plymouth-populate-initrd
@@ -1,5 +1,5 @@
  #!/bin/bash
-if ldd /proc/$$/exe |grep -q lib64; then
+if ldd /sbin/plymouthd |grep -q lib64; then
      LIBDIR="/usr/lib64"
  else
      LIBDIR="/usr/lib"
-- 
1.6.2.2


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
