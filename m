From: Tim Mohlmann <muhlemmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dmsquash-live fails for Gentoo squashed root
Date: Sat, 21 Dec 2013 23:38:09 +0100
Message-ID: <CAHOCc192zXwdsJ4Mk2cMYwwXWbV31U-cdMga6CFuJPzxNOm99Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XWSyRebBMT1wi1T1/IYMDol11cX0+p3nKUWtbWdBpvQ=;
        b=1CQbe1FWk3BLM1qzl/kC4AY98abljWrehox4LBaGx5zwHTGvwNy/mL63ZtlgDAxQBs
         tuI1vaBM5bluQKHCYh4K74piS+zSCM+XrJHjJXklkQR2BVP/9Xtx7NBoAoW5PzVkETFC
         Zh1+WGQK2cXuROE620jpT8IldyGyU3tCXmiXVXFSFA9sQZCF1anOcwgU1Xyj+QnYMUVG
         QuEfDNKEDgftnZtHFEWNqTCbNTdR//o3k/iE4MJB+CQJNXU91kFDt+tQRu0VBYEbmnJM
         ml/we/hQLlcwzMQXkISuHsSLHbGRjLM9Xqo30qZIXHJn15E95uKpPKjRyuWPM2Devpjs
         uM2w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I am playing around with a Gentoo root filesystem on a squash image on
a USB stick. I am trying to boot it with dracut dmsquash-live module.

It fails with error mount: unknown filesystem type 'DM_snapshot_cow'
repeated quite some times.

I checked if it is a kernel config problem: DM_SNAPSHOT [=y].
So I guess that is fine. Searching for COW does not five me anything
usefull, except for BLK_DEV_COW_COMMON [=n]. But it is not mentioned
where in the menuconfig it is mentioned to select.

Setting this option directly in .config gets undone when compiling the kernel.

kernel-3.10.17-gentoo
sys-kernel/dracut-034-r2  USE="device-mapper -debug -net (-selinux)"
DRACUT_MODULES="dmsquash-live lvm plymouth -biosdevname -bootchart
-btrfs -caps -cifs -crypt -crypt-gpg -crypt-loop -dash -dmraid
-gensplash -iscsi -livenet -mdraid -multipath -nbd -nfs -ssh-client
-syslog -systemd"

Kernel command line:
"root=live:UUID=81689ddf-98ab-4314-b420-ce78d505f919 rw
init=/usr/lib/systemd/systemd"

squashfs.img resides in LiveOS directory on root of USB stick with above UUID.

Regards, Tim
