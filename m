From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] dracut: Do not stop installing drivers if one fails
Date: Wed, 07 May 2014 17:58:54 +0200
Message-ID: <3223446.4k6qIrFfuT@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--add-drivers and --filesystems kernel drivers are added via:
instmods -c
The check option makes the function return if one driver could not get
installed without trying to install further drivers which is bad.

The user is still informed ($_silent is by default no), but all modules
passed to instmods are tried to be loaded, even if one fails.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

Index: dracut-037/dracut-functions.sh
===================================================================
--- dracut-037.orig/dracut-functions.sh
+++ dracut-037/dracut-functions.sh
@@ -1689,18 +1689,16 @@ instmods() {
         if (($# == 0)); then  # filenames from stdin
             while read _mod; do
                 inst1mod "${_mod%.ko*}" || {
-                    if [[ "$_check" == "yes" ]]; then
-                        [[ "$_silent" == "no" ]] && dfatal "Failed to install module $_mod"
-                        return 1
+                    if [[ "$_check" == "yes" ]] && [[ "$_silent" == "no" ]]; then
+                        dfatal "Failed to install module $_mod"
                     fi
                 }
             done
         fi
         while (($# > 0)); do  # filenames as arguments
             inst1mod ${1%.ko*} || {
-                if [[ "$_check" == "yes" ]]; then
-                    [[ "$_silent" == "no" ]] && dfatal "Failed to install module $1"
-                    return 1
+                if [[ "$_check" == "yes" ]] && [[ "$_silent" == "no" ]]; then
+                    dfatal "Failed to install module $1"
                 fi
             }
             shift
