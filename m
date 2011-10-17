From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] features: RUNDIR, imgdir, ... [update 1]
Date: Tue, 18 Oct 2011 00:40:18 +0200
Message-ID: <1318891218-5603-1-git-send-email-soltys@ziu.info>
References: <1318463387-31868-2-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318463387-31868-2-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Make sure we actually mimic host's structure to not end with duplicate
files (harmless but wasteful) on hosts, where lib and lib64 point to the
same place.

We detect symlink/dir presence in the creation loop, so we don't have to
worry about $[usr]libdir.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/dracut b/dracut
index 1d5f2f4..191998a 100755
--- a/dracut
+++ b/dracut
@@ -530,9 +530,13 @@ export initdir dracutbasedir dracutmodules drivers \
 
 # initial directory layout + host safe symlinks
 if [[ $kernel_only != yes ]]; then
+    for d in /{bin,sbin,etc,lib{,64},var,usr{,/{bin,sbin,lib{,64}}}}; do
+        if [[ -h $d ]]; then inst_symlink $d
+        elif [[ -d $d ]]; then inst_dir $d; fi
+    done
+
     mkdir -m 0755 -p \
-        "${initdir}${imgdir}"/{bin,etc,lib,${libdir#/},sbin,var,usr/{bin,sbin}} \
-        "${initdir}"/{dev,proc,sys,${newroot#/},root,run/{lock,initramfs},tmp}
+        "${initdir}"/{dev,proc,sys,${newroot#/},root,run{,/{lock,initramfs}},tmp}
 
     # host safe symlinks (will be adjusted later), needed during inst*() calls
     ln -sfn "${initdir}"/tmp      "${initdir}${imgdir}"/tmp
@@ -540,18 +544,16 @@ if [[ $kernel_only != yes ]]; then
     ln -sfn "${initdir}"/run      "${initdir}${imgdir}"/run
     ln -sfn "${initdir}"/run      "${initdir}${imgdir}"/var/run
     ln -sfn "${initdir}"/run/lock "${initdir}${imgdir}"/var/lock
-    # initial sewing pass
-    for d in bin etc lib "${libdir#/}" sbin var usr; do
-        ln -sfn "${imgdir#/}/$d" "${initdir}/$d"
-    done
 else
-    mkdir -m 0755 -p "${initdir}${imgdir}/"{lib,${libdir#/}}
-
-    # initial sewing pass
-    for d in lib "${libdir#/}"; do
-        ln -sfn "${imgdir#/}/$d" "${initdir}/$d"
+    for d in /lib{,64}; do
+        if [[ -h $d ]]; then inst_symlink $d
+        elif [[ -d $d ]]; then inst_dir $d; fi
     done
 fi
+# initial sewing pass
+for d in "${initdir}${imgdir}"/*; do
+    ln -sfn "${imgdir#/}/${d##*/}" "${initdir}/${d##*/}"
+done
 
 # check all our modules to see if they should be sourced.
 # This builds a list of modules that we will install next.
@@ -686,13 +688,13 @@ for d in "${initdir}${imgdir}"/*; do
     s="${initdir}/${d##*/}"
     if [[ -h ${s} ]]; then
         # verify if everything is fine
-        t=$(readlink -e "${s}")
-        if [[ $t != $d ]]; then
+        t=$(readlink "${s}")
+        if [[ $t != ${d#${initdir}/} ]]; then
             dfatal "dracut: symlink mismatch ${d##*/} -/-> ${d#${initdir}/}"
             exit 1
         fi
     else
-        ln -sfn "${imgdir#/}/${d##*/}" "${s}"
+        ln -sfn "${d#${initdir}/}" "${s}"
     fi
 done
 
-- 
1.7.5.3
