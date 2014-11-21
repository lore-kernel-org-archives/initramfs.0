From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 02/15] dracut: Do not stop installing drivers if one fails
Date: Fri, 21 Nov 2014 14:20:38 +0100
Message-ID: <1416576051-62838-3-git-send-email-trenn@suse.de>
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

--add-drivers and --filesystems kernel drivers are added via:
instmods -c
The check option makes the function return if one driver could not get
installed without trying to install further drivers which is bad.

The user is still informed ($_silent is by default no), but all modules
passed to instmods are tried to be loaded, even if one fails.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut-functions.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index d85c639..13c2f11 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -1742,18 +1742,16 @@ instmods() {
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
-- 
1.8.5.2
