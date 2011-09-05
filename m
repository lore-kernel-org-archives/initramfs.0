From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [RFC 2/6] 90(md|dm)raid: recognize ddf container
Date: Tue,  6 Sep 2011 00:17:24 +0200
Message-ID: <1315261048-19544-3-git-send-email-soltys@ziu.info>
References: <1315261048-19544-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315261048-19544-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch adds ddf support, consistently with imsm/isw options.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut.kernel.7.xml                             |    6 ++++++
 modules.d/90dmraid/61-dmraid-imsm.rules         |    1 +
 modules.d/90dmraid/parse-dm.sh                  |    4 ++++
 modules.d/90mdraid/65-md-incremental-imsm.rules |    3 ++-
 modules.d/90mdraid/md-noddf.sh                  |    5 +++++
 modules.d/90mdraid/md-noimsm.sh                 |    2 +-
 modules.d/90mdraid/module-setup.sh              |    6 +++++-
 modules.d/90mdraid/parse-md.sh                  |    6 ++++++
 8 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100755 modules.d/90mdraid/md-noddf.sh

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index b6e59e6..8d50d94 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -343,6 +343,12 @@ This parameter can be specified multiple times.</para>
           </listitem>
         </varlistentry>
         <varlistentry>
+          <term><envar>rd.md.ddf</envar>=0</term>
+          <listitem>
+            <para>disable MD RAID for SNIA ddf raids, use DM RAID instead</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
           <term>
             <envar>rd.md.conf</envar>=0
           </term>
diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules b/modules.d/90dmraid/61-dmraid-imsm.rules
index d87fce7..73ba58e 100644
--- a/modules.d/90dmraid/61-dmraid-imsm.rules
+++ b/modules.d/90dmraid/61-dmraid-imsm.rules
@@ -10,6 +10,7 @@ ENV{ID_FS_TYPE}=="linux_raid_member", GOTO="dm_end"
 ENV{ID_FS_TYPE}!="*_raid_member", , GOTO="dm_end"
 
 ENV{ID_FS_TYPE}=="isw_raid_member", ENV{rd_NO_MDIMSM}!="?*", GOTO="dm_end"
+ENV{ID_FS_TYPE}=="ddf_raid_member", ENV{rd_NO_MDDDF}!="?*", GOTO="dm_end"
 
 ENV{rd_NO_DM}=="?*", GOTO="dm_end"
 
diff --git a/modules.d/90dmraid/parse-dm.sh b/modules.d/90dmraid/parse-dm.sh
index 059c396..fe38d35 100755
--- a/modules.d/90dmraid/parse-dm.sh
+++ b/modules.d/90dmraid/parse-dm.sh
@@ -12,3 +12,7 @@ if  ! command -v mdadm >/dev/null || ! getargbool 1 rd.md.imsm -n rd_NO_MDIMSM |
     udevproperty rd_NO_MDIMSM=1
 fi
 
+if  ! command -v mdadm >/dev/null || ! getargbool 1 rd.md.ddf -n rd_NO_MDDDF || getarg noddfmd; then
+    info "rd.md.ddf=0: no MD RAID for SNIA ddf raids"
+    udevproperty rd_NO_MDDDF=1
+fi
diff --git a/modules.d/90mdraid/65-md-incremental-imsm.rules b/modules.d/90mdraid/65-md-incremental-imsm.rules
index 7c1d503..d02afee 100644
--- a/modules.d/90mdraid/65-md-incremental-imsm.rules
+++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
@@ -4,9 +4,10 @@
 
 ACTION!="add|change", GOTO="md_inc_end"
 SUBSYSTEM!="block", GOTO="md_inc_end"
-ENV{ID_FS_TYPE}!="linux_raid_member|isw_raid_member", GOTO="md_inc_end"
+ENV{ID_FS_TYPE}!="*_raid_member", GOTO="md_inc_end"
 
 ENV{ID_FS_TYPE}=="isw_raid_member", ENV{rd_NO_MDIMSM}=="?*", GOTO="md_inc_end"
+ENV{ID_FS_TYPE}=="ddf_raid_member", ENV{rd_NO_MDDDF}=="?*", GOTO="md_inc_end"
 
 ENV{rd_NO_MD}=="?*", GOTO="md_inc_end"
 
diff --git a/modules.d/90mdraid/md-noddf.sh b/modules.d/90mdraid/md-noddf.sh
new file mode 100755
index 0000000..bc46dd7
--- /dev/null
+++ b/modules.d/90mdraid/md-noddf.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+info "rd.md.ddf=0: no MD RAID for SNIA ddf raids"
+udevproperty rd_NO_MDDDF=1
diff --git a/modules.d/90mdraid/md-noimsm.sh b/modules.d/90mdraid/md-noimsm.sh
index bc9cf7f..8272f86 100755
--- a/modules.d/90mdraid/md-noimsm.sh
+++ b/modules.d/90mdraid/md-noimsm.sh
@@ -2,4 +2,4 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 info "rd.md.imsm=0: no MD RAID for imsm/isw raids"
-udevproperty rd_NO_MDIMSM=1
\ No newline at end of file
+udevproperty rd_NO_MDIMSM=1
diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index 91a0769..ae432ba 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -20,7 +20,7 @@ check() {
             check_block_and_slaves is_mdraid "$_rootdev" || return 1
         else
             # root is not on a block device, use the shotgun approach
-            blkid | egrep -q '(linux|isw)_raid' || return 1
+            blkid | grep -q '"[^"]*_raid_member"' || return 1
         fi
     }
 
@@ -59,9 +59,13 @@ install() {
 
     inst_rules "$moddir/65-md-incremental-imsm.rules"
 
+    # guard against pre-3.0 mdadm versions, that can't handle containers
     if ! mdadm -Q -e imsm /dev/null &> /dev/null; then
         inst_hook pre-trigger 30 "$moddir/md-noimsm.sh"
     fi
+    if ! mdadm -Q -e ddf /dev/null &> /dev/null; then
+        inst_hook pre-trigger 30 "$moddir/md-noddf.sh"
+    fi
 
     if [[ $hostonly ]] || [[ $mdadmconf = "yes" ]]; then
         if [ -f /etc/mdadm.conf ]; then
diff --git a/modules.d/90mdraid/parse-md.sh b/modules.d/90mdraid/parse-md.sh
index 6d1b615..adcc402 100755
--- a/modules.d/90mdraid/parse-md.sh
+++ b/modules.d/90mdraid/parse-md.sh
@@ -42,3 +42,9 @@ if ! getargbool 1 rd.md.imsm -n rd_NO_MDIMSM || getarg noiswmd || getarg nodmrai
     info "no MD RAID for imsm/isw raids"
     udevproperty rd_NO_MDIMSM=1
 fi
+
+# same thing with ddf containers
+if ! getargbool 1 rd.md.ddf -n rd_NO_MDDDF || getarg noddfmd || getarg nodmraid; then
+    info "no MD RAID for SNIA ddf raids"
+    udevproperty rd_NO_MDDDF=1
+fi
-- 
1.7.5.3
