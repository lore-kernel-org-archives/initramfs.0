From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [PATCH] Tidy up some comments
Date: Thu, 29 Oct 2009 09:29:58 +0000
Message-ID: <4AE96096.6010804@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=KIgFvgq7BsLdPHJ3fvO7VfJzO+04pJxxtRtugAWHEX4=;
        b=G80bmDDkk0YA2ohXws6F0We/Qn+f4PCHiMVbByoJ3qrFINA9cnTDmyGEF4l7i9wozq
         P8nWsdVGpuJeiSB8x5uEucyx2eWMQSP7Snoo3Vij/zxOk/m45KbQrZxKgBqQ4xmQBief
         MWpn4ZkorG7MYLyBWZRG5HwHQNNaJFtScKxuA=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Fix a few typos.

diff --git a/dracut b/dracut
index 7b9304f..3404fdd 100755
--- a/dracut
+++ b/dracut
@@ -193,7 +193,7 @@ fi
 # This builds a list of modules that we will install next.
 check_modules
   
-#source our modules.
+# source our modules.
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
     mod=${moddir##*/}; mod=${mod#[0-9][0-9]}
     if strstr "$mods_to_load" " $mod "; then
diff --git a/dracut-functions b/dracut-functions
index dc7e74d..499c092 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -111,7 +111,7 @@ get_numeric_dev() {
 # so, there are no slave devices for volume groups.
 # Logical volumes only have the slave devices they really live on,
 # but you cannot create the logical volume without the volume group.
-# And the volume group might be bigger than the devices the LV needes.
+# And the volume group might be bigger than the devices the LV needs.
 check_vol_slaves() {
     for i in /dev/mapper/*; do 
 	lv=$(get_numeric_dev $i)
@@ -175,7 +175,7 @@ inst_simple() {
     cp -pfL "$src" "${initdir}$target"
 }
 
-# Same as above, but specialzed to handle dynamic libraries.
+# Same as above, but specialized to handle dynamic libraries.
 # It handles making symlinks according to how the original library
 # is referenced.
 inst_library() {
@@ -268,7 +268,7 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
 
-# find a rule in the usual places.
+# find a udev rule in the usual places.
 find_rule() {
     [[ -f $1 ]] && { echo "$1"; return 0; }
     for r in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/rules.d; do
@@ -438,7 +438,7 @@ for_each_kmod_dep() {
     done
 }
 
-# filter kernel modules to install certian modules that meet specific
+# filter kernel modules to install certain modules that meet specific
 # requirements.
 # $1 = function to call with module name to filter.
 #      This function will be passed the full path to the module to test.

