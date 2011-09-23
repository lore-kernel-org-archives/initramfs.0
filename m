From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: dracut [PATCH] Parameter expansion occurs before command evaluation.
Date: Fri, 23 Sep 2011 08:02:23 -0700
Message-ID: <4E7C9F7F.7010601@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060307090703080701070709"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------060307090703080701070709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Bash shell expands all ${parameter} before evaluating a command.
For multiple declarations and assignments within the same 'local' command,
then new variables or new values that appear towards the left
do not affect parameter expansion towards the right.

-- 
John Reiser, jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org

--------------060307090703080701070709
Content-Type: text/plain;
 name="0001-Parameter-expansion-occurs-before-command-evaluation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Parameter-expansion-occurs-before-command-evaluation.pa";
 filename*1="tch"

From 507ad6f66fc66f868a9e5fdd3806e012c4022baa Mon Sep 17 00:00:00 2001
From: John Reiser <jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org>
Date: Fri, 23 Sep 2011 07:37:43 -0700
Subject: [PATCH] Parameter expansion occurs before command evaluation.

${parameter} on the right is expanded before evaluating "local var=value"
on the left.

---
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 5508809..c4f7f61 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -272,7 +272,7 @@ check_vol_slaves() {
 inst_dir() {
     [[ -e ${initdir}"$1" ]] && return 0  # already there
 
-    local _dir="$1" _part=${_dir%/*} _file
+    local _dir="$1" _part="${1%/*}" _file
     while [[ "$_part" != "${_part%/*}" ]] && ! [[ -e "${initdir}${_part}" ]]; do
         _dir="$_part $_dir"
         _part=${_part%/*}
-- 
1.7.6


--------------060307090703080701070709--
