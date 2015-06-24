From: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] modules: base: include wc utility
Date: Wed, 24 Jun 2015 17:17:00 +0200
Message-ID: <87h9pxjfv7.fsf@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=TYFrVclslrNsD8DvoxX4DzmllqgNRGJXeDD0TxPApyY=;
        b=LtuQHV1Rw8z5+SOyNHHjD1dXXEb3hJP8Gq9uuIMj5osE4qAt1odr8bFcJnm0VPtetu
         9losWnvqac/1ntyyWvDC8Trhi57APy/K/4QO0UGBEABbygiwQmHqs6gsK1wN3ObRwaG7
         tSlOAjkeFFVIliaQeI0Hk1JcrUj71A06kAdL5xeBlaIz9F2cfZW9rH1oJQUOujKoKgKz
         EjA3gffH3jArJpYfXCkbyAHArEWI1DcdJnymusRZ5+4JTThi6y8z31qy6bkT4nol5fcc
         OqefUgo+pdAHAPrFp7TguEwPVU/8i/TgZBe6d/iDK77qtCN/UFPNz2vcCe6TV7ENTZX0
         w2eA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Commit cfa365a32d47 ("lvm: Don't activate LVs with activationskip set")
introduces a usage of the wc utility.

Make it available in the initramfs through the base module.

Signed-off-by: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/99base/module-setup.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index bbc68ba..5b89028 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -16,7 +16,8 @@ install() {
     local _d
 
     inst_multiple mount mknod mkdir sleep chroot chown \
-        sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid
+        sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid \
+        wc
     inst $(command -v modprobe) /sbin/modprobe
 
     inst_multiple -o findmnt less kmod
-- 
2.4.4
