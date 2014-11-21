From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 14/15] 95rootfs-block: Correctly terminate commandline parameter
Date: Fri, 21 Nov 2014 14:20:50 +0100
Message-ID: <1416576051-62838-15-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

95rootfs-block would not terminate the commandline parameter with
a space or newline, instead it'll rely on the main routine from
dracut.sh to do this.
Which will cause unexpected problems for any modules called
after this.

So terminate the commandline parameters correctly here and remove
the newline from dracut.sh.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh                                | 1 -
 modules.d/95rootfs-block/module-setup.sh | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 3c3efc1..3577e51 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1290,7 +1290,6 @@ if [[ $print_cmdline ]]; then
         module_cmdline "$_d_mod"
     done
     unset moddir
-    printf "\n"
     exit 0
 fi
 
diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95rootfs-block/module-setup.sh
index 81de177..33875f8 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -22,7 +22,7 @@ cmdline_journal() {
             fi
 
             if [ -n "$journaldev" ]; then
-                printf " root.journaldev=%s" "$journaldev"
+                echo "root.journaldev=${journaldev}"
             fi
         done
     fi
@@ -32,9 +32,9 @@ cmdline_journal() {
 cmdline_rootfs() {
     local dev=/dev/block/$(find_root_block_device)
     if [ -e $dev ]; then
-        printf " root=%s" "$(shorten_persistent_dev "$(get_persistent_dev "$dev")")"
-        printf " rootflags=%s" "$(find_mp_fsopts /)"
-        printf " rootfstype=%s" "$(find_mp_fstype /)"
+        printf "root=%s" "$(shorten_persistent_dev "$(get_persistent_dev "$dev")")"
+        printf "rootflags=%s" "$(find_mp_fsopts /)"
+        printf "rootfstype=%s\n" "$(find_mp_fstype /)"
     fi
 }
 
-- 
1.8.5.2
