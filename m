From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 3/3] Add dm_mod loader
Date: Fri, 16 Oct 2009 11:00:04 +0200
Message-ID: <1255683604-10667-3-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

Some kernel configurations might build base dm support as a module.
Add module dm which ensures that dm_mod is there and loaded.
---
 modules.d/90dm/check          |    4 ++++
 modules.d/90dm/dm-pre-udev.sh |    1 +
 modules.d/90dm/install        |    4 ++++
 modules.d/90dm/installkernel  |    2 ++
 modules.d/90dmraid/check      |    3 +++
 modules.d/90lvm/check         |    3 +++
 6 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/90dm/check
 create mode 100644 modules.d/90dm/dm-pre-udev.sh
 create mode 100755 modules.d/90dm/install
 create mode 100755 modules.d/90dm/installkernel

diff --git a/modules.d/90dm/check b/modules.d/90dm/check
new file mode 100755
index 0000000..008f04f
--- /dev/null
+++ b/modules.d/90dm/check
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+exit 255
+
diff --git a/modules.d/90dm/dm-pre-udev.sh b/modules.d/90dm/dm-pre-udev.sh
new file mode 100644
index 0000000..67eeb1c
--- /dev/null
+++ b/modules.d/90dm/dm-pre-udev.sh
@@ -0,0 +1 @@
+modprobe dm_mod
diff --git a/modules.d/90dm/install b/modules.d/90dm/install
new file mode 100755
index 0000000..2ec0630
--- /dev/null
+++ b/modules.d/90dm/install
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+inst_hook pre-udev 30 "$moddir/dm-pre-udev.sh"
+
diff --git a/modules.d/90dm/installkernel b/modules.d/90dm/installkernel
new file mode 100755
index 0000000..f970827
--- /dev/null
+++ b/modules.d/90dm/installkernel
@@ -0,0 +1,2 @@
+#!/bin/bash
+instmods dm_mod
diff --git a/modules.d/90dmraid/check b/modules.d/90dmraid/check
index eacec60..147b7fa 100755
--- a/modules.d/90dmraid/check
+++ b/modules.d/90dmraid/check
@@ -1,5 +1,8 @@
 #!/bin/bash
 
+# We depend on dm_mod being loaded
+[ "$1" = "-d" ] && echo dm
+
 # if we don't have dmraid installed on the host system, no point
 # in trying to support it in the initramfs.
 which dmraid >/dev/null 2>&1 || exit 1
diff --git a/modules.d/90lvm/check b/modules.d/90lvm/check
index 25f24e2..20f21e8 100755
--- a/modules.d/90lvm/check
+++ b/modules.d/90lvm/check
@@ -1,5 +1,8 @@
 #!/bin/bash
 
+# We depend on dm_mod being loaded
+[ "$1" = "-d" ] && echo dm
+
 # No point trying to support lvm if the binaries are missing
 which lvm >/dev/null 2>&1 || exit 1
 
-- 
1.6.0.4
