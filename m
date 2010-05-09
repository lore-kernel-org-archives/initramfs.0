From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Do not require .conf suffix for files in /etc/modprobe.d
Date: Sun, 09 May 2010 22:24:04 +0400
Message-ID: <20100509182404.3768.46609.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Currently dracut will install only modprobe configuration files
matching *.conf. module-init-tools itself does not have this restriction
and uses blacklist for known pre-/suffixes instead. Some distributions
(e.g. Mandriva) widely use files without .conf suffix. Let dracut
accept the same set of files as module-init-tools will.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/90kernel-modules/install |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-modules/install
index 2f19d0c..33438d5 100755
--- a/modules.d/90kernel-modules/install
+++ b/modules.d/90kernel-modules/install
@@ -1,4 +1,24 @@
 #!/bin/bash
 [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
-dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
+
+# This matches blacklist used by module-init-tools
+dracut_install $(find /etc/modprobe.d/ \
+	-name '.*' -o \
+	-name '~*' -o \
+	-name '*.rpmsave' -o \
+	-name '*.rpmorig' -o \
+	-name '*.rpmnew' -o \
+	-name '*.dpkg-old' -o \
+	-name '*.dpkg-dist' -o \
+	-name '*.dpkg-new' -o \
+	-name '*.dpkg-bak' -o \
+	-name '*.bak' -o \
+	-name '*.orig' -o \
+	-name '*.rej' -o \
+	-name '*.YaST2save' -o \
+	-name '*.-' -o \
+	-name '*~' -o \
+	-name '*,v' -o \
+	-type f -print)
+
 inst_hook cmdline 01 "$moddir/parse-kernel.sh"
