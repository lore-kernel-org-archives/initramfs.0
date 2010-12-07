From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. f8dd8dcf14fa3992a90fb4e631c248069fe8ea20
Date: Tue,  7 Dec 2010 14:26:28 +0000
Message-ID: <E1PPyV0-0002P3-Lp@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  f8dd8dcf14fa3992a90fb4e631c248069fe8ea20 (commit)
       via  d3898996b06a721346e8d034b0cc07e35ad993d3 (commit)
       via  7cfd77a0f14a9ffef420c19ce85709af31d6f79a (commit)
      from  e48ff7a5efe3cabc137c5f29aced884e006805b7 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit f8dd8dcf14fa3992a90fb4e631c248069fe8ea20
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Dec 6 16:05:37 2010 +0100

    mdraid/parse-md.sh: create new rules, then mv to old one
    
    If udevd is already running, then we should assemble the new rules files
    in a seperate file first, before calling it *.rules
    
    Resolves: rhbz#595096

diff --git a/modules.d/90mdraid/parse-md.sh b/modules.d/90mdraid/parse-md.sh
index 6e2a3bf..c4638f8 100644
--- a/modules.d/90mdraid/parse-md.sh
+++ b/modules.d/90mdraid/parse-md.sh
@@ -6,21 +6,20 @@ else
 
     # rewrite the md rules to only process the specified raid array
     if [ -n "$MD_UUID" ]; then
-	for f in /etc/udev/rules.d/65-md-incremental*.rules; do
-	    [ -e "$f" ] || continue
-	    mv $f ${f}.bak 
-	    while read line; do 
-		if [ "${line%%UUID CHECK}" != "$line" ]; then
-		    for uuid in $MD_UUID; do
-			printf 'ENV{MD_UUID}=="%s", GOTO="do_md_inc"\n' $uuid
-		    done;
- 		    printf 'GOTO="md_inc_end"\n';		
-		else
-		    echo $line; 
-		fi
-	    done < ${f}.bak > $f
-	    rm ${f}.bak 
-	done
+        for f in /etc/udev/rules.d/65-md-incremental*.rules; do
+            [ -e "$f" ] || continue
+            while read line; do 
+                if [ "${line%%UUID CHECK}" != "$line" ]; then
+                    for uuid in $MD_UUID; do
+                        printf 'ENV{MD_UUID}=="%s", GOTO="do_md_inc"\n' $uuid
+                    done;
+                    printf 'GOTO="md_inc_end"\n';               
+                else
+                    echo $line; 
+                fi
+            done < "${f}" > "${f}.new"
+            mv "${f}.new" "$f" 
+        done
     fi
 fi
 
commit d3898996b06a721346e8d034b0cc07e35ad993d3
Author: Peter Rajnoha <prajnoha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 18:14:59 2010 +0100

    *.rules: honor DM_UDEV_DISABLE_OTHER_RULES_FLAG
    
    honour the DM_UDEV_DISABLE_OTHER_RULES_FLAG which is set by
    libdevmapper/LVM directly for devices that should be skipped.

diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules b/modules.d/90dmraid/61-dmraid-imsm.rules
index 4d608cc..d87fce7 100644
--- a/modules.d/90dmraid/61-dmraid-imsm.rules
+++ b/modules.d/90dmraid/61-dmraid-imsm.rules
@@ -13,6 +13,8 @@ ENV{ID_FS_TYPE}=="isw_raid_member", ENV{rd_NO_MDIMSM}!="?*", GOTO="dm_end"
 
 ENV{rd_NO_DM}=="?*", GOTO="dm_end"
 
+ENV{DM_UDEV_DISABLE_OTHER_RULES_FLAG}=="1", GOTO="dm_end"
+
 PROGRAM=="/bin/sh -c 'for i in $sys/$devpath/holders/dm-[0-9]*; do [ -e $$i ] && exit 0; done; exit 1;' ", \
     GOTO="dm_end"
 
diff --git a/modules.d/95udev-rules/59-persistent-storage-volid.rules b/modules.d/95udev-rules/59-persistent-storage-volid.rules
index ca24358..0b798e6 100644
--- a/modules.d/95udev-rules/59-persistent-storage-volid.rules
+++ b/modules.d/95udev-rules/59-persistent-storage-volid.rules
@@ -1,7 +1,7 @@
 SUBSYSTEM!="block", GOTO="psv_end"
 ACTION!="add|change", GOTO="psv_end"
-ACTION=="change", KERNEL=="dm-[0-9]*", IMPORT{program}="vol_id --export $tempnode"
+ACTION=="change", KERNEL=="dm-[0-9]*", ENV{DM_UDEV_DISABLE_OTHER_RULES_FLAG}!="1", IMPORT{program}="vol_id --export $tempnode"
 KERNEL=="cciss[0-9]*", IMPORT{program}="vol_id --export $tempnode"
 KERNEL=="nbd[0-9]*", IMPORT{program}="vol_id --export $tempnode"
 KERNEL=="md[0-9]*|md_d[0-9]*|md/*", IMPORT{program}="vol_id --export $tempnode"
-LABEL="psv_end"
\ No newline at end of file
+LABEL="psv_end"
diff --git a/modules.d/95udev-rules/59-persistent-storage.rules b/modules.d/95udev-rules/59-persistent-storage.rules
index 89c7609..2b83e72 100644
--- a/modules.d/95udev-rules/59-persistent-storage.rules
+++ b/modules.d/95udev-rules/59-persistent-storage.rules
@@ -29,6 +29,7 @@ KERNEL!="dm-[0-9]*", GOTO="ps_end"
 ACTION=="add", GOTO="ps_end"
 IMPORT{program}="/sbin/dmsetup info -c --nameprefixes --unquoted --rows --noheadings -o name,uuid,suspended,readonly,major,minor,open,tables_loaded,names_using_dev -j%M -m%m"
 ENV{DM_NAME}!="?*", GOTO="ps_end"
+ENV{DM_UDEV_DISABLE_OTHER_RULES_FLAG}=="1", GOTO="ps_end"
 ENV{DM_UUID}=="CRYPT-TEMP-?*", GOTO="ps_end"
 ENV{DM_UUID}!="?*", ENV{DM_NAME}=="temporary-cryptsetup-?*", GOTO="ps_end"
 IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
diff --git a/modules.d/95udev-rules/61-persistent-storage.rules b/modules.d/95udev-rules/61-persistent-storage.rules
index c549e1b..9cfdb0b 100644
--- a/modules.d/95udev-rules/61-persistent-storage.rules
+++ b/modules.d/95udev-rules/61-persistent-storage.rules
@@ -1,7 +1,7 @@
 SUBSYSTEM!="block", GOTO="pss_end"
 ACTION!="add|change", GOTO="pss_end"
 
-ACTION=="change", KERNEL=="dm-[0-9]*", GOTO="do_pss"
+ACTION=="change", KERNEL=="dm-[0-9]*", ENV{DM_UDEV_DISABLE_OTHER_RULES_FLAG}!="1", GOTO="do_pss"
 KERNEL=="cciss[0-9]*", GOTO="do_pss"
 KERNEL=="nbd[0-9]*", GOTO="do_pss"
 KERNEL=="md[0-9]*|md_d[0-9]*|md/*", GOTO="do_pss"
@@ -17,4 +17,4 @@ ENV{DEVTYPE}=="partition", ENV{ID_PATH}=="?*", SYMLINK+="disk/by-path/$env{ID_PA
 # by-label/by-uuid links (filesystem metadata)
 ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{ID_FS_UUID_ENC}=="?*", SYMLINK+="disk/by-uuid/$env{ID_FS_UUID_ENC}"
 ENV{ID_FS_USAGE}=="filesystem|other", ENV{ID_FS_LABEL_ENC}=="?*", SYMLINK+="disk/by-label/$env{ID_FS_LABEL_ENC}"
-LABEL="pss_end"
\ No newline at end of file
+LABEL="pss_end"
commit 7cfd77a0f14a9ffef420c19ce85709af31d6f79a
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Oct 18 16:07:58 2010 +0200

    add 96insmodpost dracut module
    
    due to popular demand, this module loads a custom kernel module, after the
    first udev settle (all basic device drivers loaded)

diff --git a/modules.d/96insmodpost/check b/modules.d/96insmodpost/check
new file mode 100755
index 0000000..e0292c8
--- /dev/null
+++ b/modules.d/96insmodpost/check
@@ -0,0 +1,5 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+exit 0
diff --git a/modules.d/96insmodpost/insmodpost.sh b/modules.d/96insmodpost/insmodpost.sh
new file mode 100755
index 0000000..f3bd780
--- /dev/null
+++ b/modules.d/96insmodpost/insmodpost.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+. /lib/dracut-lib.sh
+
+for p in $(getargs rdinsmodpost=); do 
+    modprobe $p
+done
diff --git a/modules.d/96insmodpost/install b/modules.d/96insmodpost/install
new file mode 100755
index 0000000..4509d1b
--- /dev/null
+++ b/modules.d/96insmodpost/install
@@ -0,0 +1,6 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+inst_hook cmdline 20 "$moddir/parse-insmodpost.sh"
+inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
diff --git a/modules.d/96insmodpost/parse-insmodpost.sh b/modules.d/96insmodpost/parse-insmodpost.sh
new file mode 100755
index 0000000..4cfd355
--- /dev/null
+++ b/modules.d/96insmodpost/parse-insmodpost.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+for p in $(getargs rdinsmodpost=); do 
+    echo "blacklist $p" >> /etc/modprobe.d/initramfsblacklist.conf
+    _do_insmodpost=1
+done
+
+[ -n "$_do_insmodpost" ] && /sbin/initqueue --settled --unique --onetime /sbin/insmodpost.sh
+unset _do_insmodpost
-----------------------------------------------------------------------

Summary of changes:
 modules.d/90dmraid/61-dmraid-imsm.rules            |    2 +
 modules.d/90mdraid/parse-md.sh                     |   29 +++++++++----------
 .../95udev-rules/59-persistent-storage-volid.rules |    4 +-
 modules.d/95udev-rules/59-persistent-storage.rules |    1 +
 modules.d/95udev-rules/61-persistent-storage.rules |    4 +-
 modules.d/96insmodpost/check                       |    5 +++
 modules.d/96insmodpost/insmodpost.sh               |    8 +++++
 modules.d/96insmodpost/install                     |    6 ++++
 modules.d/96insmodpost/parse-insmodpost.sh         |   11 +++++++
 9 files changed, 51 insertions(+), 19 deletions(-)
 create mode 100755 modules.d/96insmodpost/check
 create mode 100755 modules.d/96insmodpost/insmodpost.sh
 create mode 100755 modules.d/96insmodpost/install
 create mode 100755 modules.d/96insmodpost/parse-insmodpost.sh


-- 
dracut - Initramfs generator using udev
