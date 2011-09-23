From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: dracut [PATCH]es: parallelize block_module filter and net_module_filter
Date: Fri, 23 Sep 2011 09:17:13 -0700
Message-ID: <4E7CB109.9020500@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050908080903020705010104"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------050908080903020705010104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Filtering modules requires enough work that instmods() in the
next pipeline stage was rarely busy.  Parallelize the two
filters which do the most work.  Also fix a filename-vs-contents
mistake in net_module_filter.

-- 
John Reiser, jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org

--------------050908080903020705010104
Content-Type: text/plain;
 name="0001-Parallelize-block_module_filter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Parallelize-block_module_filter.patch"

From f4533a2ceca52c443ddebec01eeaa35d51c39c1b Mon Sep 17 00:00:00 2001
From: John Reiser <jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org>
Date: Tue, 13 Sep 2011 17:41:43 -0700
Subject: [PATCH 1/3] Parallelize block_module_filter

---
 modules.d/90kernel-modules/module-setup.sh |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 9fc4248..09bd87e 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -11,12 +11,22 @@ installkernel() {
         }
         block_module_filter() {
             local _blockfuncs='ahci_init_controller|ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
-            local _f
-            while read _f; do case "$_f" in
-                *.ko)    [[ $(<         $_f) =~ $_blockfuncs ]] && echo "$_f" ;;
-                *.ko.gz) [[ $(gzip -dc <$_f) =~ $_blockfuncs ]] && echo "$_f" ;;
-                esac
-            done
+            function bmf1() {
+                local _f
+                while read _f; do case "$_f" in
+                    *.ko)    [[ $(<         $_f) =~ $_blockfuncs ]] && echo "$_f" ;;
+                    *.ko.gz) [[ $(gzip -dc <$_f) =~ $_blockfuncs ]] && echo "$_f" ;;
+                    esac
+                done
+            }
+            # Use two parallel streams to filter alternating modules.
+            local merge side2
+            ( ( local _f1 _f2
+                while  read _f1; do   echo "$_f1"
+                    if read _f2; then echo "$_f2" 1>&${side2}; fi
+                done \
+                | bmf1     1>&${merge}    ) {side2}>&1 \
+                | bmf1  )      {merge}>&1
         }
         hostonly='' instmods sr_mod sd_mod scsi_dh scsi_dh_rdac scsi_dh_emc
         hostonly='' instmods pcmcia firewire-ohci
-- 
1.7.6


--------------050908080903020705010104
Content-Type: text/plain;
 name="0002-Parallelize-net_module_filter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Parallelize-net_module_filter.patch"

From 5aadc01b17db78ca3e7ef34b16cced11305fd737 Mon Sep 17 00:00:00 2001
From: John Reiser <jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org>
Date: Tue, 13 Sep 2011 17:42:05 -0700
Subject: [PATCH 2/3] Parallelize net_module_filter

Conflicts:

	modules.d/40network/module-setup.sh
---
 modules.d/40network/module-setup.sh |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index cb81269..4106cf7 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -27,18 +27,26 @@ installkernel() {
     net_module_filter() {
         local _net_drivers='eth_type_trans|register_virtio_device'
         local _unwanted_drivers='/(wireless|isdn|uwb)/'
-        local _fname
-        while read _fname; do
-            local _fcont
-            case "$_fname" in
-                *.ko)    _fcont="$(<        $_fname)" ;;
-                *.ko.gz) _fcont="$(gzip -dc $_fname)" ;;
-            esac
-            [[   $_fcont =~ $_net_drivers
-            && ! $_fcont =~ iw_handler_get_spy \
-            && ! $_fname =~ $_unwanted_drivers ]] \
-            && echo "$_fname"
-        done
+        function nmf1() {
+            local _fname _fcont
+            while read _fname; do
+                case "$_fname" in
+                    *.ko)    _fcont="$(<        $_fname)" ;;
+                    *.ko.gz) _fcont="$(gzip -dc $_fname)" ;;
+                esac
+                [[   $_fcont =~ $_net_drivers
+                && ! $_fcont =~ iw_handler_get_spy|$_unwanted_drivers ]] \
+                && echo "$_fname"
+            done
+        }
+        # Use two parallel streams to filter alternating modules.
+        local merge side2
+        ( ( local _f1 _f2
+            while  read _f1; do   echo "$_f1"
+                if read _f2; then echo "$_f2" 1>&${side2}; fi
+            done \
+            | nmf1     1>&${merge}    ) {side2}>&1 \
+            | nmf1  )      {merge}>&1
     }
 
     find_kernel_modules_by_path drivers/net | net_module_filter | instmods
-- 
1.7.6


--------------050908080903020705010104
Content-Type: text/plain;
 name="0003-Fix-nmf1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-Fix-nmf1.patch"

From 67e77533c3f6031d108468a1015e2fb88460e866 Mon Sep 17 00:00:00 2001
From: John Reiser <jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org>
Date: Fri, 23 Sep 2011 09:01:50 -0700
Subject: [PATCH 3/3] Fix nmf1

---
 modules.d/40network/module-setup.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index 4106cf7..03684f1 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -30,12 +30,13 @@ installkernel() {
         function nmf1() {
             local _fname _fcont
             while read _fname; do
+                [[ $_fname =~ $_unwanted_drivers ]] && continue
                 case "$_fname" in
                     *.ko)    _fcont="$(<        $_fname)" ;;
                     *.ko.gz) _fcont="$(gzip -dc $_fname)" ;;
                 esac
                 [[   $_fcont =~ $_net_drivers
-                && ! $_fcont =~ iw_handler_get_spy|$_unwanted_drivers ]] \
+                && ! $_fcont =~ iw_handler_get_spy ]] \
                 && echo "$_fname"
             done
         }
-- 
1.7.6


--------------050908080903020705010104--
