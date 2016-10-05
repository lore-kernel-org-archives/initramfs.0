From: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
Subject: [RFC/PATCH] Give --persistent_policy precedence over /dev/mapper names
Date: Wed,  5 Oct 2016 14:13:03 +0200
Message-ID: <20161005121303.31582-1-mwilck@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>

There is currently no way to override dracut's preference for
/dev/mapper device names. But using these is problematic in
different scenarios: For example, if a user has a multipath-
enabled system but wants to disable multipath, or if the
names of multipath maps change because of configuration changes
(e.g. toggling user_friendly_names in /etc/multipath.conf).

This patch makes dracut prefer the user-specified
--persistent_policy names over /dev/mapper names.

It might be worthwhile to discuss why dracut prefers /dev/mapper
of /dev/disk/by-uuid at all. This preference was introduced
in 9037b63e with the argument "dm devices maintain /dev/mapper/* as
persistent names", but that's wrong for the scenarios mentioned
above, and is not a compelling reason for preferring /dev/mapper
over /dev/disk/by-uuid.

Signed-off-by: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
---
 dracut-functions.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 249d8fb..e97765d 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -223,14 +223,20 @@ get_devpath_block() {
 
 # get a persistent path from a device
 get_persistent_dev() {
-    local i _tmp _dev
+    local i _tmp _dev _pol
 
     _dev=$(get_maj_min "$1")
     [ -z "$_dev" ] && return
 
+    if [[ -n "$persistent_policy" ]]; then
+	_pol="/dev/disk/${persistent_policy}/*"
+    else
+	_pol=
+    fi
+
     for i in \
+        $_pol \
         /dev/mapper/* \
-        /dev/disk/${persistent_policy:-by-uuid}/* \
         /dev/disk/by-uuid/* \
         /dev/disk/by-label/* \
         /dev/disk/by-partuuid/* \
-- 
2.10.0
