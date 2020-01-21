From: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut: Verify multipath config_dir option
Date: Tue, 21 Jan 2020 17:38:34 +0530
Message-ID: <20200121120834.GA23866@machine1>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579608522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PD1TFILxKy5kITv5WVCAiD+ogMob5z7Pc9fgJmwcKng=;
        b=MiEABLXI1na13Y/imxy9oECVdnA1LZZHjdJ+b8tgg0Nl+q4Sv7z1xX4xhOLm3qxTJdVsuW
        XkaH/SMQJJ6byh5baiGw8K42cavnefLrD0uTkhBwoc1Q0SIhRyEphyO0dlhlP8p76Q3MfW
        LXB3gI40bR+1pMPm6aH3jgOf+r1Pcmc=
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

The 90multipath/module-setup.sh file currently does not check the
dm-multipath config_dir option. This option in multipath.conf file is
used to specify a custom directory/path that contains the multipath
configuration files. It's default value is /etc/multipath/conf.d

Currently install function of module-setup.sh has hardcoded the above
path, but users could change it with config_dir option. So, adding a
command to get the directory specified with config_dir option and add
these configuration files to the initial ram disk image.

Signed-off-by: Milan P. Gandhi <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90multipath/module-setup.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index 1f6a55ec..f7c521c1 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -78,6 +78,9 @@ install() {
         }
     }
 
+    # Include multipath configuration files from path specified with config_dir
+    config_dir=`/usr/sbin/multipath -t|grep -i config_dir|awk '{print $2}'|sed -e 's/^"//' -e 's/"$//'`/*
+
     inst_multiple -o  \
         dmsetup \
         kpartx \
@@ -90,7 +93,7 @@ install() {
         /etc/xdrdevices.conf \
         /etc/multipath.conf \
         /etc/multipath/* \
-        /etc/multipath/conf.d/*
+        $config_dir
 
     [[ $hostonly ]] && [[ $hostonly_mode = "strict" ]] && {
         for_each_host_dev_and_slaves_all add_hostonly_mpath_conf
-- 
2.20.1

