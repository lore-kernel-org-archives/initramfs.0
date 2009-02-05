From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 3/3] add more disk id helpers to udevexe
Date: Thu, 05 Feb 2009 15:49:25 -0700
Message-ID: <20090205224925.18610.64666.stgit@dwillia2-linux.ch.intel.com>
References: <20090205224808.18610.14957.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090205224808.18610.14957.stgit-p8uTFz9XbKjBPTuBivz2/GFmcEqAMTzPQQ4Iyu8u01E@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: neilb-l3A5Bk7waGM@public.gmane.org, jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

Allow udev to create /dev/disk/by-id links

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 513b6c6..da86a23 100755
--- a/dracut
+++ b/dracut
@@ -73,7 +73,7 @@ raidexe="/sbin/mdadm /sbin/mdmon"
 # and some things that are nice for debugging
 debugexe="/bin/ls /bin/cat /bin/ln /bin/ps /bin/grep /bin/more"
 # udev things we care about
-udevexe="/lib/udev/vol_id /lib/udev/console_init"
+udevexe="/lib/udev/*_id /lib/udev/console_init"
 
 # install base files
 for binary in $exe $debugexe $udevexe $lvmexe $cryptexe $raidexe ; do

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
