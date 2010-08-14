From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/16] Bashify error() and usage() in mkinitrd-dracut.sh
Date: Sat, 14 Aug 2010 14:23:25 -0500 (CDT)
Message-ID: <782e5043254f19bf9a5369fb5dda5fcf1f32d249.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=7iAiVKi7OEVzU0FQV9LfWvbJ3FcHDxgey51R3Tm7V7A=;
        b=Z0pC9lpJcRqsEe23x+p1G/DBojdqZwyQaM96kbEhVmYSVIiLy6+cr6T6KsOQz46G7l
         43Ckpg3pMx9vbkM35GfVslK1KZH1OLfSWwm+6/0iKUJzs3NH9kcLoYZMhvifxkpOicWu
         7WZJC5KkNwxW48qVwyviLiQZ1jvRcG2KXMUmM=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Some more trivial bashification.

---
 mkinitrd-dracut.sh |   27 +++++++--------------------
 1 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index 59333a7..3943dad 100644
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -1,32 +1,19 @@
 #!/bin/bash --norc
+kver=$(uname -r)
 
-error() {
-    local NONL=""
-    if [ "$1" == "-n" ]; then
-        NONL="-n"
-        shift
-    fi
-    echo $NONL "$@" > /dev/stderr
-}
+error() { echo "$@" >&2; }
 
 usage () {
-    if [ "$1" == "-n" ]; then
-        cmd=echo
-    else
-        cmd=error
-    fi
+    [[ $1 = '-n' ]] && cmd=echo || cmd=error
 
-    $cmd "usage: `basename $0` [--version] [--help] [-v] [-f] [--preload <module>]"
+    $cmd "usage: ${0%/*} [--version] [--help] [-v] [-f] [--preload <module>]"
     $cmd "       [--image-version] [--with=<module>]"
     $cmd "       <initrd-image> <kernel-version>"
     $cmd ""
-    $cmd "       (ex: `basename $0` /boot/initramfs-$(uname -r).img $(uname -r))"
+    $cmd "       (ex: ${0%/*} /boot/initramfs-$kver.img $kver)"
 
-    if [ "$1" == "-n" ]; then
-        exit 0
-    else
-        exit 1
-    fi
+    [[ $1 = '-n' ]] && exit 0
+    exit 1
 }
 
 
-- 
1.7.2.1
