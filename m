From: Jacek Danecki <Jacek.Danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/14] Make Intel BIOS raid use mdraid instead of dmraid
 when mdadm 3.0 is available
Date: Mon, 20 Jul 2009 19:39:18 +0200
Message-ID: <4A64ABC6.30901@intel.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com> <1247676646-3837-4-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-4-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harald Hoyer wrote:
> diff --git a/modules.d/90mdraid/mdraid_start.sh b/modules.d/90mdraid/mdraid_start.sh
> index 3475b7e..7293ded 100755
> --- a/modules.d/90mdraid/mdraid_start.sh
> +++ b/modules.d/90mdraid/mdraid_start.sh
> @@ -4,5 +4,14 @@ if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
>      [ -h "$job" ] && rm -f "$job"
>      # run mdadm if udev has settled
>      mdadm -IRs
> +    # and activate any containers
> +    for md in /dev/md?*; do
> +        case $md in
> +            /dev/md*p*) ;;
> +            *)
> +                if mdadm --export --detail $md | grep -q container; then
> +                    mdadm -IR $md

These commands are not executed because /dev/md directory was not created.
In rdshell I've executed:
# rm /tmp/.mdraid_start-sd*
# udevadm trigger

KERNEL[1248110873.408893] add      /devices/virtual/block/md126 (block)
KERNEL[1248110873.408938] add      /devices/virtual/block/md127 (block)
KERNEL[1248110873.408972] change   /devices/virtual/block/md127 (block)

sh-4.0# cat /proc/mdstat 
Personalities : [raid1] 
md127 : inactive sdb[1](S) sda[0](S)
      4514 blocks super external:imsm
       
unused devices: <none>

sh-4.0# ls -l /dev/md*
brw-rw---- 1 0 disk 9, 126 Jul 20 16:56 /dev/md126
brw-rw---- 1 0 disk 9, 127 Jul 20 17:27 /dev/md127

If I run mdadm -IR manually:

sh-4.0# mdadm -IR /dev/md127
md: bind<sdb>
md: bind<sda>
raid1: raid set md126 active with 2 out of 2 mirrors
KERNEL[1248110956.850769] changemd126: detected capacity change from 0 to 10737418240
   /devices/virt md126:ual/block/md126  p1(block)
 p2
KERNEL[1248110956.863417] change   /devices/virtual/block/md126 (block)
KERNEL[1248110956.863656] add      /devices/virtual/blomd: md126 switched to read-write mode.
ck/md126/md126p1 (block)
KERNEL[1248110956.863841] add      /devices/virtual/block/md126/md126p2 (block)
mdadm: Started /dev/md/raid1_0 with 2 devices

sh-4.0# cat /proc/mdstat 
Personalities : [raid1] 
md127 : inactive sdb[1](S) sda[0](S)
      4514 blocks super external:imsm
       
md126 : active (auto-read-only) raid1 sda[1] sdb[0]
      10485760 blocks super external:/md127/0 [2/2] [UU]
      
unused devices: <none>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
