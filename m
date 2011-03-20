From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] dracut: fix arithemtic ${#VAR[@]} tests
Date: Sun, 20 Mar 2011 20:56:17 +0100
Message-ID: <1300650977-29456-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch fixes a handful of ${#VAR[@]} tests, which can't be evaluated
as text expressions - the results is always true in such case, because
"0" is non-empty string.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/dracut b/dracut
index 0c1cc14..dd32b88 100755
--- a/dracut
+++ b/dracut
@@ -276,48 +276,48 @@ if [[ $confdir && -d $confdir ]]; then
 fi
 
 # these optins add to the stuff in the config file
-if [[ ${#add_dracutmodules_l[@]} ]]; then
+if (( ${#add_dracutmodules_l[@]} )); then
     while pop add_dracutmodules_l val; do
         add_dracutmodules+=" $val "
     done
 fi
 
-if [[ ${#add_drivers_l[@]} ]]; then
+if (( ${#add_drivers_l[@]} )); then
     while pop add_drivers_l val; do
         add_drivers+=" $val "
     done
 fi
 
 # these options override the stuff in the config file
-if [[ ${#dracutmodules_l[@]} ]]; then
+if (( ${#dracutmodules_l[@]} )); then
     dracutmodules=''
     while pop dracutmodules_l val; do
         dracutmodules+="$val "
     done
 fi
 
-if [[ ${#omit_dracutmodules_l[@]} ]]; then
+if (( ${#omit_dracutmodules_l[@]} )); then
     omit_dracutmodules=''
     while pop omit_dracutmodules_l val; do
         omit_dracutmodules+="$val "
     done
 fi
 
-if [[ ${#drivers_l[@]} ]]; then
+if (( ${#drivers_l[@]} )); then
     drivers=''
     while pop drivers_l val; do
         drivers+="$val "
     done
 fi
 
-if [[ ${#filesystems_l[@]} ]]; then
+if (( ${#filesystems_l[@]} )); then
     filesystems=''
     while pop filesystems_l val; do
         filesystems+="$val "
     done
 fi
 
-if [[ ${#fw_dir_l[@]} ]]; then
+if (( ${#fw_dir_l[@]} )); then
     fw_dir=''
     while pop fw_dir_l val; do
         fw_dir+="$val "
-- 
1.7.2.1
