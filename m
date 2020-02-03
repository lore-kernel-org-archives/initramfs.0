From: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] dracut: Verify multipath config_dir option
Date: Mon, 3 Feb 2020 17:00:34 +0530
Message-ID: <20200203113034.GA19959@machine1>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IF6gXn4Ox96kCFORDvmhe4DFrVfusDlri4KprXZ2n0k=;
        b=fcczhEKfMSN5sFhiQMZ9CPE15/5ge8t1ZhkKX4vRv3x3Cs6GfL1D7a+ZOueP3aNnx/ZGsL
        quPYBLiSPOybprpU8j07mq83ok3YFqgs3iy5h6pOtD5mepXY/zTk4DNiuoXR9xZoY91Zln
        8EXql4x9qO56wFPt01zwvo0YO43Ntj4=
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mwilck-IBi9RG/b67k@public.gmane.org

The 90multipath/module-setup.sh file currently does not check the
dm-multipath config_dir option. This option in multipath.conf file is
used to specify a custom directory/path that contains the multipath
configuration files. It's default value is /etc/multipath/conf.d

Currently install function of module-setup.sh has hardcoded the above
path, but users could change it with config_dir option. So, adding
steps to read the path specified with config_dir option and add
these configuration files to the initial ram disk image.

Signed-off-by: Milan P. Gandhi <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

changes v2:
 - Removed awk/sed usage to get config_dir path
 - Added a check to verify if path specifed with
   config_dir is actual directory

 modules.d/90multipath/module-setup.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index 48a9d09a..7609ff52 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -79,6 +79,20 @@ install() {
         }
     }
 
+    # Include multipath configuration files from path specified with config_dir
+    while read _k _v; do
+        if [[ "$_k" = config_dir ]]; then
+            _v=${_v#\"}
+            config_dir=${_v%\"}
+        fi
+    done < <(/sbin/multipath -t)
+
+    if [ -d "$config_dir" ]; then
+        config_dir+="/*"
+    else
+        echo "multipath.conf: config_dir - No such directory $config_dir"
+    fi
+
     inst_multiple -o  \
         dmsetup \
         kpartx \
@@ -91,7 +105,7 @@ install() {
         /etc/xdrdevices.conf \
         /etc/multipath.conf \
         /etc/multipath/* \
-        /etc/multipath/conf.d/*
+        $config_dir
 
     [[ $hostonly ]] && [[ $hostonly_mode = "strict" ]] && {
         for_each_host_dev_and_slaves_all add_hostonly_mpath_conf
-- 
2.20.1

