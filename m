From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. 8a6939656f5ce12157725eee6c8c21a83b3cbe56
Date: Wed,  9 Feb 2011 13:48:45 +0000
Message-ID: <E1PnAPg-0006o8-81@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  8a6939656f5ce12157725eee6c8c21a83b3cbe56 (commit)
       via  a735202636444a19d4aa4a86566bf15138e9e2bd (commit)
      from  8c4549ff18aa27d46969db8deb32725be6ecaf35 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 8a6939656f5ce12157725eee6c8c21a83b3cbe56
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Feb 8 17:59:48 2011 +0100

    dracut-functions: write to $HOME/dracut.log instead of /tmp/dracut.log

diff --git a/dracut-functions b/dracut-functions
index 99e0c2e..597f8a7 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -28,8 +28,7 @@ strstr() { [[ $1 =~ $2 ]]; }
 if ! [[ $dracutlogfile ]]; then
     [[ $dracutbasedir = /usr/share/dracut ]] && \
 	dracutlogfile=/var/log/dracut.log || \
-	dracutlogfile=/tmp/dracut.log
-#    [[ -w $dracutlogfile ]] || dracutlogfile=/tmp/dracut.log
+	dracutlogfile=$HOME/dracut.log
     if [[ -w $dracutlogfile ]]; then
         >"$dracutlogfile"
     fi
commit a735202636444a19d4aa4a86566bf15138e9e2bd
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Feb 8 12:28:37 2011 +0100

    biosdevname: unbashify parse-biosdevname.sh

diff --git a/modules.d/97biosdevname/parse-biosdevname.sh b/modules.d/97biosdevname/parse-biosdevname.sh
index 9b18d15..09b0cec 100755
--- a/modules.d/97biosdevname/parse-biosdevname.sh
+++ b/modules.d/97biosdevname/parse-biosdevname.sh
@@ -1,7 +1,7 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 USE_BIOSDEVNAME=$(getarg biosdevname)
-if [[ $USE_BIOSDEVNAME != "1" ]]; then
+if [ $USE_BIOSDEVNAME != "1" ]; then
     udevproperty UDEV_BIOSDEVNAME=
     rm -f /etc/udev/rules.d/71-biosdevname.rules
 else
-----------------------------------------------------------------------

Summary of changes:
 dracut-functions                             |    3 +--
 modules.d/97biosdevname/parse-biosdevname.sh |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)


-- 
dracut - Initramfs generator using udev
