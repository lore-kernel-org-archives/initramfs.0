From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/16] Flatten our check to ensure that depmod works.
Date: Sat, 14 Aug 2010 14:23:25 -0500 (CDT)
Message-ID: <ac8c3698378e96b681622e52f4a76386c60737d3.1281812505.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=27ImCLo5exF9e7ph4TdeCtu2QsMR6DeYYRxQG2RTfkY=;
        b=byrtvsT+3WhTVr64bPaBimuCJO0OvmuHfsg2WcZGa0y8U2VfYHoMRYZv1ZysYXGVPY
         Pe+qDqEfBGKEtCfglfTlaZ0UcaaNWUEwAhIkmIziP42h9KYVCREX7CalIS23+QuicEjm
         v030kqpBA19W6vQxtW0uOTGkGl0gV05MK+AXM=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

No need for a nested if here.

---
 dracut |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/dracut b/dracut
index 184b0c1..bfef92c 100755
--- a/dracut
+++ b/dracut
@@ -270,11 +270,10 @@ unset moddir
 ## final stuff that has to happen
 
 # generate module dependencies for the initrd
-if [[ -d $initdir/lib/modules/$kernel ]]; then
-    if ! depmod -a -b "$initdir" $kernel; then
-        derror "\"depmod -a $kernel\" failed."
-        exit 1
-    fi
+if [[ -d $initdir/lib/modules/$kernel ]] && \
+    ! depmod -a -b "$initdir" $kernel; then
+    derror "\"depmod -a $kernel\" failed."
+    exit 1
 fi
 
 if [[ $include_src && $include_target ]]; then
-- 
1.7.2.1
