From: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Subject: MD Raid1 driver missing from hostonly initramfs
Date: Fri, 25 Jan 2013 11:30:16 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1301251127050.31163@jlaw-desktop.mno.stratus.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joe Lawrence <joe.lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>

Hi Harald,

Another bug report... when I run dracut in host-only mode on an MD raid1
install, the raid1.ko driver is not included in the initramfs.

See MD raid1 root / boot cfg:

  % cat /etc/mdadm.conf 
  # mdadm.conf written out by anaconda
  MAILADDR root
  AUTO +imsm +1.x -all
  ARRAY /dev/md/boot level=raid1 num-devices=2 UUID=cbbe4fdc:2747d5c2:b33330b7:365f9bee
  ARRAY /dev/md/root level=raid1 num-devices=2 UUID=b5e4bddd:e76802b0:3b6badd6:e85ebc27
  ARRAY /dev/md/swap level=raid1 num-devices=2 UUID=ed672ba5:c3cf93c8:27cb42f3:591ee749
  ARRAY /dev/md/var_crash level=raid1 num-devices=2 UUID=acbe94ef:9bd6d56b:09f449b5:5138e918
  
  % cat /proc/mounts | grep -e md125 -e md127
  /dev/md125 / ext4 rw,seclabel,relatime,data=ordered 0 0
  /dev/md127 /boot ext4 rw,seclabel,relatime,data=ordered 0 0
  
  % blkid | grep -e md125 -e md127
  /dev/md127: UUID="1a46136f-b673-45f4-80ee-275a1a1eb011" TYPE="ext4" 
  /dev/md125: UUID="b17b7afa-f257-4255-8eca-53cf7c9e1e7f" TYPE="ext4"


When adding debug text to check_mdraid function in modules.d/90mdraid/
module-setup.sh, I see an instance for root and boot:

  dev=/dev/md125 fs=ext4
  dev=/dev/md127 fs=ext4

which makes sense given that the check_mdraid function is invoked by the
module's check function via for_each_host_dev_fs.

Unfortunately, it seems that check_mdraid wants to operate on MD component
devices, not the MD device itself.  Does this make sense?  If so, should 
it be invoked via something like for_each_host_dev_and_slaves?

Alternatively, maybe check_mdraid should be modified to just use the MD
device.  It looks like all that it is trying to do is figure out the
MD_UUID, which can be found via mdadm --detail --export.  If that is all
that is required, see the patch below.  I'm not sure what other corner
cases (like stacked MD devices) would need to be tested...

Regards,

-- Joe


From 8d3a3e3e418977600ffdaffafb2b8f23ec8d9bb0 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 24 Jan 2013 17:18:22 -0500
Subject: [PATCH] fix mdraid check_mdraid to operate on md device

The check_mdraid function in 90mdraid/module-setup.sh is passed an MD device
device / filesystem, not a component disk.  It should expect to see
XXX_raid_member filetype and determine the associated MD_UUID from mdadm
using --detail instead of --examine.

Signed-off-by: Joe Lawrence <joe.lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
---
 modules.d/90mdraid/module-setup.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index 3b5620c..38ab0fa 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -9,9 +9,8 @@ check() {
 
     check_mdraid() {
         local dev=$1 fs=$2 holder DEVPATH MD_UUID
-        [[ "$fs" = "${fs%%_raid_member}" ]] && return 1
 
-        MD_UUID=$(/sbin/mdadm --examine --export $dev \
+        MD_UUID=$(/sbin/mdadm --detail --export $dev \
             | while read line; do
                 [[ ${line#MD_UUID} = $line ]] && continue
                 eval "$line"
-- 
1.8.0.2
