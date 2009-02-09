From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:34:50 -0800 (PST)
Message-ID: <4d96775e6a86278392eef7c6b9f4efcce4cfb357.1234137267.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=v7Tf7XREwFY8xkcJv2DaMEZyvRbbLUesJCO0sIL1wOQ=;
        b=ECBYGJREQVrd3+XZG82yJo/8umkBfP3ezClVd42NKMyW0Gg0RQVex31yFSl7XWF18W
         SCRZ8YFIhk1tjsMsC0FfZFEt+K8XjRxhAvP3rAkIlgn2Rz24Vm2PkDMuM1tcArLSQi+N
         cfO0d4vGKqge1LFewQb03Ykg2T8jySKjimTFQ=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Use getarg to get the root kernel commandline parameter.

---
 init |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/init b/init
index b5b0b1b..7b2a985 100755
--- a/init
+++ b/init
@@ -58,13 +58,8 @@ NEWROOT="/sysroot"
 # FIXME: there's got to be a better way ...
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
-for o in `cat /proc/cmdline` ; do
-  case $o in 
-  root=*)
-    root=${o#root=}
-    ;;
-  esac
-done
+root=$(getarg 'root=*'); root=${root#root=}
+
 echo -n "Going to mount rootfs ($root)"
 if [ -z "$root" ]; then 
   echo "Warning: no root specified"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
