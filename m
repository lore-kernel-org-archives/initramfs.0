From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/8] install_kmod_with_fw: make fast case faster
Date: Tue, 30 Aug 2011 21:39:41 -0700
Message-ID: <4E5DBB0D.8070400@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut-functions |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 15a75b9..9d941d7 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -782,13 +782,14 @@ check_module_dir() {
 # Install a single kernel module along with any firmware it may require.
 # $1 = full path to kernel module to install
 install_kmod_with_fw() {
-    local _modname=${1##*/} _fwdir _found _fw
-    _modname=${_modname%.ko*}
     # no need to go further if the module is already installed
     [[ -e "${initdir}/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" ]] \
         && return 0
     inst_simple "$1" "/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" \
         || return $?
+
+    local _modname=${1##*/} _fwdir _found _fw
+    _modname=${_modname%.ko*}
     for _fw in $(modinfo -k $kernel -F firmware $1 2>/dev/null); do
         _found=''
         for _fwdir in $fw_dir; do
-- 
1.7.6


-- 
