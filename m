From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 20/42] Handle module alias properly
Date: Thu, 11 Dec 2014 15:46:11 +0100
Message-ID: <1418309193-11208-21-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Some modules (like ext4) provide aliases by which the modules
can be accessed, too. But when using aliases directly dracut
fails to include the correct module. So translate the alias
into the correct module name before checking the module.

References: bnc#886839

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut-functions.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index edd8ea9..7a12a76 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -1689,6 +1689,13 @@ instmods() {
             --*) _mpargs+=" $_mod" ;;
             *)
                 _mod=${_mod##*/}
+                # Check for aliased modules
+                _modalias=$(modinfo -k $kernel -F filename $_mod 2> /dev/null)
+                _modalias=${_modalias%.ko}
+                if [ "${_modalias##*/}" != "$_mod" ] ; then
+                    _mod=${_modalias##*/}
+                fi
+
                 # if we are already installed, skip this module and go on
                 # to the next one.
                 if [[ $DRACUT_KERNEL_LAZY_HASHDIR ]] && \
-- 
1.8.5.2
