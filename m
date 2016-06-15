From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] kernel-modules: handle nfs host fstype properly
Date: Wed, 15 Jun 2016 17:40:24 +0800
Message-ID: <1465983624-12964-1-git-send-email-xlpang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

There are scenarios that support fstype target not mounted
beforehand, kdump can utilize this feature to avoid imposing
severe overload on the shared nfs server when thousands of
diskless clients with nfs kdumping boot and trigger kdump
initramfs rebuild synchronously.

Because target is not mounted beforehand, some of the kernel
modules will fail to be installed in hostonly mode. Dracut
actually can support this by instmods all "host_fs_types" with
hostonly unset in 90kernel-modules/module-setup.sh installkernel().

This works properly for most host fstypes(ext[234]/xfs, etc), but
that's not the case for nfs.

From nfs manpage, we can clearly see:
"The fstype field contains "nfs". Use of the "nfs4" fstype in
/etc/fstab is deprecated."

It means "nfs" specified can be actually mounted as "nfs[3-4]", so
for these cases, the current 90kernel-modules implementation only
installs ko modules for "nfs"(nfs.ko, etc), lacking nfsv[3-4].ko,
so it cannot work properly. In order to address the issue, we should
install all the possbile kernel modules for "nfs" fstype:
"nfs sunrpc ipv6 nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files".

Additionally, we need a special remapping for "nfs[3-4]" deprecated
cases, for example, we should map "nfs4" to "nfsv4.ko" not "nfs4.ko".

Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 7904c02..1f57ec7 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -44,7 +44,25 @@ installkernel() {
                 dracut_instmods -o -P ".*/(kernel/fs/nfs|kernel/fs/nfsd|kernel/fs/lockd)/.*" '=fs'
             fi
         else
-            hostonly='' instmods "${host_fs_types[@]}"
+            for i in "${host_fs_types[@]}"; do
+                if [[ $i = nfs ]]; then
+                    # nfs manpage says:
+                    # "The fstype field contains "nfs". Use of the "nfs4" fstype in
+                    # /etc/fstab is deprecated."
+                    #
+                    # It means "nfs" can be actually mounted as "nfs4", so for "nfs"
+                    # host fstype we better install all the possible kernel modules,
+                    # this is useful for kdump "nfs" dumping not mounted beforehand.
+                    #
+                    # The list is copied from "95nfs/module_setup.sh installkernel()".
+                    i="nfs sunrpc ipv6 nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files"
+                elif [[ $i = nfs[3-4] ]]; then
+                    # Deprecated cases, we provide support, but need a name mapping:
+                    # For example, should map "nfs4" to use "nfsv4.ko" not "nfs4.ko".
+                    i=${i/nfs/nfsv}
+                fi
+                hostonly='' instmods $i
+            done
         fi
     fi
     :
-- 
1.8.3.1
