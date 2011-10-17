From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] dracut: remove duplicate options
Date: Mon, 17 Oct 2011 23:01:49 +0200
Message-ID: <1318885310-12535-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'-I' and '--fwdir' were both read_arg and push_arg, and the latter has
priority.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index 205f5d1..4bc0db3 100755
--- a/dracut
+++ b/dracut
@@ -212,8 +212,6 @@ while (($# > 0)); do
         -c|--conf)     read_arg conffile             "$@" || shift;;
         --confdir)     read_arg confdir              "$@" || shift;;
         -L|--stdlog)   read_arg stdloglvl_l          "$@" || shift;;
-        -I|--install)  read_arg install_items        "$@" || shift;;
-        --fwdir)       read_arg fw_dir_l             "$@" || shift;;
         --compress)    read_arg compress_l           "$@" || shift;;
         --prefix)      read_arg prefix_l             "$@" || shift;;
         -f|--force)    force=yes;;
-- 
1.7.5.3
