From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC][PATCH 9/9] init: remove "root=" command line option test for tmpfs decision
Date: Wed,  7 Jan 2015 15:53:00 -0500
Message-ID: <1420663980-20842-10-git-send-email-zohar@linux.vnet.ibm.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

The "root=" option is interpreted by the kernel sometimes and passed
on to userspace other times.  Based on whether the "root=" boot
command line option is specified, the initramfs uses tmpfs or ramfs
as the rootfs.

This is a temporary patch that removes the "root=" test in the
decision to use tmpfs or ramfs as the rootfs.  Modify userspace
applications (eg. dracut, systemd) to support "ROOT=" in addition
to "root=".

(Not to be upstreamed.)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 init/do_mounts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 82f2288..b2f5e7d 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -622,7 +622,7 @@ int __init init_rootfs(void)
 	if (err)
 		return err;
 
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
+	if (IS_ENABLED(CONFIG_TMPFS) &&
 		(!root_fs_names || strstr(root_fs_names, "tmpfs"))) {
 		err = shmem_init();
 		is_tmpfs = true;
-- 
1.8.1.4

