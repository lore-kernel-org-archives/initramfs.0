From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH 2/2] [99fs-lib] Provide fs_mount_to_var utility function to parse /path:type:/dev,options style mountspecs
Date: Thu, 11 Apr 2013 17:39:22 +0200
Message-ID: <1365694762-7806-2-git-send-email-devurandom@gmx.net>
References: <1365694762-7806-1-git-send-email-devurandom@gmx.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365694762-7806-1-git-send-email-devurandom-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>

---
 modules.d/99fs-lib/fs-lib.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
index 9e6abf6..15e2b91 100755
--- a/modules.d/99fs-lib/fs-lib.sh
+++ b/modules.d/99fs-lib/fs-lib.sh
@@ -287,3 +287,29 @@ fs_add_mount() {
 	[ "${pass}" ] || pass=0
 	echo "${fs} ${mountpoint} ${fstype} ${options} ${dump} ${pass}" >> /etc/fstab."${phase}"
 }
+
+# fs_mount_to_var MOUNTSPEC
+# use MOUNTSPEC to set $mountpoint, $fstype, $fs and $options.
+# MOUNTSPEC is something like: [<mountpoint>]:<fstype>:<fs>[,<options>]
+fs_mount_to_var() {
+	local arg="$1"
+
+	options="${arg#*,}"
+	[ "${options}" = "${arg}" ] && unset options
+	arg="${arg%%,${options}}"
+
+	mountpoint="${arg%%:*}"
+	[ "${mountpoint}" = "${arg}" ] && die "Unable to parse mountpoint out of $1"
+	arg="${arg##${mountpoint}:}"
+
+	if [ "${mountpoint}" = "${mountpoint#/}" ] ; then
+		fstype="${mountpoint}"
+		mountpoint=/
+	else
+		fstype="${arg%%:*}"
+		[ "${fstype}" = "${arg}" ] && die "Unable to parse fstype out of $1"
+		arg="${arg##${fstype}:}"
+	fi
+
+	fs="${arg}"
+}
-- 
1.8.1.5
