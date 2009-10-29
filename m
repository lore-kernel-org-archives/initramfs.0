From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [PATCH] dracut-gencmdline: use udevadm info to go from /dev/X to
 /sys/Y
Date: Thu, 29 Oct 2009 09:29:16 +0000
Message-ID: <4AE9606C.1090008@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=t0Z6yg7I4bKW9CgvuYZddZM9VF8u2TZ7Uh6xEgRNviQ=;
        b=Jts3HhjdE1I9Kfpbk+acHeI0pzeukPItmysZFm5ek7EwZGOgIa2VIgd+P95w9XpvQd
         qY0HD17wulYyj/esWodZf8dMTSy4Ed9yy1RUm8g4jpvZ2LAHMFadngKKOGmVrFgBgKkV
         XdfVtkFFe0I3b34IcCJ9jRAifUzAIqkcXOmgI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Avoid some manual spelunking in sysfs.  This makes for slightly shorter
and simpler code.

diff --git a/dracut-gencmdline b/dracut-gencmdline
index 625546c..a4e2c3d 100755
--- a/dracut-gencmdline
+++ b/dracut-gencmdline
@@ -169,17 +169,20 @@ resolve_device_name() {
     echo "$1" 
 }
 
+finddevinsys() {
+    path=$(udevadm info --name "$1" --query=path 2>/dev/null)
+    if [ -n "$path" ]; then
+        echo "/sys/$path"
+        return 0
+    fi
+    return 1
+}
+
 finddevnoinsys() {
     majmin="$1"
     if [ -n "$majmin" ]; then
-        dev=$(for x in /sys/block/* ; do find $x/ -name dev ; done | while read device ; do \
-              echo "$majmin" | cmp -s $device && echo $device ; done)
-        if [ -n "$dev" ]; then
-            dev=${dev%%/dev}
-            dev=${dev%%/}
-            echo "$dev"
-            return 0
-        fi
+        finddevinsys "/dev/block/$majmin"
+        return $?
     fi
     return 1
 }
@@ -252,11 +255,10 @@ findstoragedriver () {
         return
     fi
 
-    local majmin=$(get_numeric_dev dec "$device")
-    local sysfs=$(finddevnoinsys "$majmin")
+    local sysfs=$(finddevinsys "$device")
 
     if [ -z "$sysfs" ]; then
-        #error "WARNING: $device major:minor $majmin not found, skipping"
+        #error "WARNING: $device not found in sysfs, skipping"
         return
     fi
 

