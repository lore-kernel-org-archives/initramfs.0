From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 26/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:39 -0800 (PST)
Message-ID: <f567834d1e37bf5b281f6d8bfbdca32bdf375548.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=sk2RiPIfNjgQG7JZC74irsnnuZBIKOIS0+jJWw8BrYA=;
        b=pBpV8ljdQuKPmnoWRafeh6O7h/9pzHx5D2zYyx9mOqEVNb6g56hfiOa8pTUupuEvPU
         JqH2Fp3UtBszJNrxu4EcFyQyaOLYB8J+q5mL8S0jhdVuWxG9K+KeBUvhOiEEenaQR7zs
         7F78fnzwlWLFFnJ0lPLnYIcaEyEHzimVnUWY8=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Make init less noisy and load fs modules for all mounted filesystems

---
 dracut |    5 +++++
 init   |    9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index c444c92..eb6632d 100755
--- a/dracut
+++ b/dracut
@@ -115,6 +115,11 @@ for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
 
 instmods $modules
 
+# Grab modules for all filesystem types we currently know about
+while read d mp t rest; do
+    instmods "$t"
+done </proc/mounts
+
 /sbin/depmod -a -b "$initdir" $kernel || {
     error "\"/sbin/depmod -a $kernel\" failed."
     exit 1
diff --git a/init b/init
index d5095ea..10a789b 100755
--- a/init
+++ b/init
@@ -41,6 +41,7 @@ mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
 mknod /dev/tty0 c 4 0
 mknod /dev/tty1 c 4 1
+mknod /dev/null c 1 3
 
 # start plymouth if it's available
 # arguably we need some of udev run first for fbmods and above devnodes :/
@@ -50,7 +51,7 @@ mknod /dev/tty1 c 4 1
 
 # start up udev and trigger cold plugs
 udevd --daemon
-udevadm trigger
+udevadm trigger >/dev/null 2>&1
 
 # mount the rootfs
 NEWROOT="/sysroot"
@@ -59,7 +60,7 @@ NEWROOT="/sysroot"
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
 root=$(getarg 'root=*'); root=${root#root=}
-echo -n "Going to mount rootfs ($root)"
+plymouth --update "Going to mount rootfs ($root)"
 case $root in
     LABEL=*) root=${root#LABEL=}
              root=${root//\//\\x2f}
@@ -71,12 +72,12 @@ esac
 
 # should we have a timeout?
 tries=0
+plymouth --update "Waiting up to 30 seconds for $root to become available"
 until [[ -e $root ]]; do
-  echo -n "."
   sleep 1
   ((tries++ > 30)) && emergency_shell
 done
-echo -e "\n\nMounting rootfs after $tries seconds"
+plymouth --update "Mounting rootfs after $tries seconds"
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT || emergency_shell
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
