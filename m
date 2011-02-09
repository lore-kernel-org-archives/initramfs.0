From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 1cedde068192af7536479ff5fb159c75fc7d7ed6
Date: Wed,  9 Feb 2011 13:49:01 +0000
Message-ID: <E1PnAPq-0006pN-2g@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  1cedde068192af7536479ff5fb159c75fc7d7ed6 (commit)
       via  c965ed2db4062044ba43e78b28376f572878e2bf (commit)
       via  52889453c13258b3fd036bbb7a8b37df132505e3 (commit)
      from  534b0525a5bf41c7181c43ebc7ca9222e4dc7fb7 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 1cedde068192af7536479ff5fb159c75fc7d7ed6
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 9 13:22:49 2011 +0100

    plymouth: touch /dev/.systemd/plymouth
    
    until plymouth does it itsself, touch /dev/.systemd/plymouth
    https://bugzilla.redhat.com/show_bug.cgi?id=676302

diff --git a/modules.d/50plymouth/plymouth-pretrigger.sh b/modules.d/50plymouth/plymouth-pretrigger.sh
index 0800dbc..c224875 100755
--- a/modules.d/50plymouth/plymouth-pretrigger.sh
+++ b/modules.d/50plymouth/plymouth-pretrigger.sh
@@ -18,6 +18,8 @@ if getargbool 1 rd.plymouth -n rd_NO_PLYMOUTH; then
 
     info "Starting plymouth daemon"
     [ -x /bin/plymouthd ] && /bin/plymouthd --attach-to-session
+    mkdir -m 0755 /dev/.systemd >/dev/null 2>&1
+    >/dev/.systemd/plymouth
     /lib/udev/console_init tty0
     /bin/plymouth --show-splash 2>&1 | vinfo
 fi
commit c965ed2db4062044ba43e78b28376f572878e2bf
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Feb 8 18:06:25 2011 +0100

    dracut.8.xml: corrected typo

diff --git a/dracut.8.xml b/dracut.8.xml
index 34b3986..26e575b 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -298,7 +298,7 @@ Default:
             <para>activates the local mode. dracut will use modules from the current working
 directory instead of the system-wide installed modules in
 <filename>/usr/share/dracut/modules.d</filename>.
-Thsi is useful when running dracut from a git checkout.</para>
+This is useful when running dracut from a git checkout.</para>
           </listitem>
         </varlistentry>
         <varlistentry>
commit 52889453c13258b3fd036bbb7a8b37df132505e3
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Feb 8 17:59:48 2011 +0100

    dracut-functions: write to $HOME/dracut.log instead of /tmp/dracut.log

diff --git a/dracut-functions b/dracut-functions
index e80a638..9ac0bba 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -65,8 +65,7 @@ is_func() {
 if ! [[ $dracutlogfile ]]; then
     [[ $dracutbasedir = /usr/share/dracut ]] && \
         dracutlogfile=/var/log/dracut.log || \
-        dracutlogfile=/tmp/dracut.log
-#    [[ -w $dracutlogfile ]] || dracutlogfile=/tmp/dracut.log
+        dracutlogfile=$HOME/dracut.log
     if [[ -w $dracutlogfile ]]; then
         >"$dracutlogfile"
     fi
-----------------------------------------------------------------------

Summary of changes:
 dracut-functions                            |    3 +--
 dracut.8.xml                                |    2 +-
 modules.d/50plymouth/plymouth-pretrigger.sh |    2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)


-- 
dracut - Initramfs generator using udev
