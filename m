From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/11] add debug and changed verbose parameter
Date: Fri, 15 May 2009 14:39:31 +0200
Message-ID: <4A0D6283.6090805@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020903070200090403010709"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------020903070200090403010709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


previous -verbose is now -debug (set -x)
-verbose adds some information about the resulting initrd size
---
  Makefile |    2 +-
  dracut   |    9 ++++++++-
  2 files changed, 9 insertions(+), 2 deletions(-)



--------------020903070200090403010709
Content-Type: text/x-patch;
 name="c4ad7ffff4e9fc38ae68f1e7a6bf16f4bc879b7d.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="c4ad7ffff4e9fc38ae68f1e7a6bf16f4bc879b7d.diff"

diff --git a/Makefile b/Makefile
index ef264eb..7053cd9 100644
--- a/Makefile
+++ b/Makefile
@@ -44,5 +44,5 @@ check:
 	done;exit $$ret
 
 testimage: all
-	./dracut -l -f test-$(shell uname -r).img $(shell uname -r)
+	./dracut -v -l -f test-$(shell uname -r).img $(shell uname -r)
 	@echo wrote  test-$(shell uname -r).img 
diff --git a/dracut b/dracut
index 7a14765..4d42e82 100755
--- a/dracut
+++ b/dracut
@@ -15,7 +15,8 @@ while (($# > 0)); do
 	-d|--drivers) modules_l="$2"; shift;;
 	-h|--help) echo "Usage: $0 [-f] <initramfs> <kernel-version>"
 	    exit 1 ;;
-	-v|--verbose) set -x;;
+	-d|--debug) set -x;;
+	-v|--verbose) beverbose="yes";;
 	-c|--conf) conffile="$2"; shift;;
 	-l|--local) allowlocal="yes" ;;
 	-h|--hostonly) hostonly="-h" ;;
@@ -108,4 +109,10 @@ ldconfig -n -r "$initdir" /lib* /usr/lib*
     cp -a -t "$initdir$include_target" "$include_src"/*
 }
 
+[[ "$beverbose" = "yes" ]] && (du -c "$initdir" | sort -n)
+
 ( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )
+
+[[ "$beverbose" = "yes" ]] && ls -lh "$outfile"
+
+:


--------------020903070200090403010709--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
