From: Pawel Krzesniak <pawel.krzesniak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ls to stat patch
Date: Mon, 23 Nov 2009 14:44:59 +0000 (UTC)
Message-ID: <loom.20091123T144413-833@post.gmane.org>
References: <4A9F6345.4050003@gmail.com> <2C8691D2-389B-4F15-A406-AD4D51B9D0D4@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Victor Lowther <victor.lowther@...> writes:

> On Sep 3, 2009, at 1:33 AM, Joe Pelkey <pelkeyj@...> wrote:
> 
> > Hi,
> > I was randomly looking through the git repository and came across
> > modules.d/95resume/resume.sh and its comment about not liking the  
> > use of
> > ls.  I modified it to use stat instead, and since stat has been in
> > coreutils since at least late 2005, I assume it's safe to use.
> 
> <snip patch>
> 
> We had a patch that did that initally, but dropped it because it adds  
> another binary to the initramfs.

What else depends on 'ls'?
I can see 'ls' is used only in modules.d/95nfs/install which is invoked during
creating initramfs image only. Am I wrong?

btw: Joe's patch has bug, because stat returns major and minor in hex and we
need decimal values. We can use printf (which is part of dash) to convert values.

my version:

Subject: [PATCH] use stat binary instead of ls

Signed-off-by: Pawel Krzesniak <pawel.krzesniak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/95resume/install   |    1 +
 modules.d/95resume/resume.sh |    7 +++----
 modules.d/99base/install     |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/95resume/install b/modules.d/95resume/install
index 9200f95..a88d608 100755
--- a/modules.d/95resume/install
+++ b/modules.d/95resume/install
@@ -1,4 +1,5 @@
 #!/bin/bash
+dracut_install stat
 inst_hook cmdline 10 "$moddir/parse-resume.sh"
 inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
 inst_hook mount 10 "$moddir/resume.sh"
diff --git a/modules.d/95resume/resume.sh b/modules.d/95resume/resume.sh
index 8bb4114..022ef0e 100755
--- a/modules.d/95resume/resume.sh
+++ b/modules.d/95resume/resume.sh
@@ -1,8 +1,7 @@
 #!/bin/sh
 [ -s /.resume -a -b "$resume" ] && {
-    # parsing the output of ls is Bad, but until there is a better way...
-    ls -lH "$resume" | ( 
-	read x x x x maj min x;
-	echo "${maj%,}:$min"> /sys/power/resume)
+    stat -L -c "0x%t 0x%T" "$resume" | ( 
+	read maj min;
+	echo "$(printf %d $maj):$(printf %d $min)"> /sys/power/resume)
     >/.resume
 }
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 801c8d7..68c89c6 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -1,6 +1,6 @@
 #!/bin/bash
 dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln rmmod mkfifo less 
+    sed flock cp mv dmesg rm ln rmmod mkfifo less 
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
-- 
1.6.5.2


