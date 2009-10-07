From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] Have cryptroot-ask load dm_crypt if needed.
Date: Wed,  7 Oct 2009 10:48:25 -0500 (CDT)
Message-ID: <3dd50ddfef09ffcbe981d4e36becf91a53b9b6da.1254930149.git.victor.lowther@gmail.com>
References: <a989fe01e19bd214cae75b705ac0c5e8aefb71d4.1254930149.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a989fe01e19bd214cae75b705ac0c5e8aefb71d4.1254930149.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If dm_crypt is not loaded automatically whenever a LUKS encrypted partition
is detected (due to distro-specific tweaks to the udev rules or whatever),
load it manually.

---
 modules.d/90crypt/cryptroot-ask.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 0eadeeb..c10cdc6 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -9,6 +9,9 @@
 # we already asked for this device
 [ -f /tmp/cryptroot-asked-$2 ] && exit 0
 
+# load dm_crypt if it is not already loaded
+[ -d /sys/module/dm_crypt ] || modprobe dm_crypt
+
 . /lib/dracut-lib.sh
 LUKS=$(getargs rd_LUKS_UUID=)
 ask=1
-- 
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
