From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/3] dracut: Do not create early_cpio if no suitable microcode exist in hostonly case
Date: Tue, 24 Sep 2013 19:02:56 +0200
Message-ID: <1380042177-66221-3-git-send-email-trenn@suse.de>
References: <1380042177-66221-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380042177-66221-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

Intel microcodes only exist for very specific family/model/stepping CPUs.
If no microcode gets added, there is no need to create an empty
(only directories) cpio later that gets glued to the initrd.

This also fixes:

*** Constructing GenuineIntel.bin ****
cat: /lib/firmware/intel-ucode/06-3c-03: No such file or directory

in hostonly mode if there is no suitable microcode for the CPU.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 0dd1e8b..671f53f 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1316,12 +1316,15 @@ if [[ $early_microcode = yes ]]; then
                 dinfo "*** Constructing ${ucode_dest[$idx]} ****"
                 if [[ $hostonly ]]; then
                     _src=$(get_ucode_file)
+                    if ! [[ -r $_fwdir/$_fw/$_src ]];then
+                        break;
+                    fi
                 fi
                 cat $_fwdir/$_fw/$_src > $_dest_dir/${ucode_dest[$idx]}
+                create_early_cpio="yes"
             fi
         done
     done
-    create_early_cpio="yes"
 fi
 
 rm -f -- "$outfile"
-- 
1.7.6.1
