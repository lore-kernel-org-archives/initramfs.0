From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 2/2] dracut-functions: remove find_rule()
Date: Tue, 10 May 2011 14:36:24 +0200
Message-ID: <1305030984-10284-3-git-send-email-soltys@ziu.info>
References: <1305030984-10284-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305030984-10284-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Not used anymore.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut-functions |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 959c1d3..ae3d265 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -396,15 +396,6 @@ inst_symlink() {
         ln -sfn "$realsrc" "$target"
 }
 
-# find a udev rule in the usual places.
-find_rule() {
-    [[ -f $1 ]] && { echo "$1"; return 0; }
-    for r in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/rules.d; do
-        [[ -f $r/$1 ]] && { echo "$r/$1"; return 0; }
-    done
-    return 1
-}
-
 # udev rules always get installed in the same place, so
 # create a function to install them to make life simpler.
 inst_rules() {
-- 
1.7.2.1
