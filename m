From: Miroslav Shaltev <shaltev-ng3u6l8Qjkg@public.gmane.org>
Subject: dmraid - possible boot fail due to mdraid rules?
Date: Fri, 9 Jan 2015 13:50:54 +0100
Message-ID: <20150109135054.66bac1f1@pulsar.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dear all,

i have a question regarding the dmraid module.

On a centos 7 system (but i am afraid the problem is distro independent)

kernel: 3.10.0-123.13.2.el7.x86_64
dracut: dracut-033-161.el7.x86_64
storage: dmraid 1 with lvm on top

with a root on a dmraid device, some mdraid udev rules get pulled into
the initramfs.

The output of dracut -M 

bash i18n network ifcfg drm plymouth dm dmraid kernel-modules lvm
resume rootfs-block terminfo udev-rules biosdevname systemd usrmount
base fs-lib shutdown

gives no hint about that. However 

grep -r "64-md-raid.rules"  dracut/modules.d/*

dracut/modules.d/90dmraid/module-setup.sh: inst_rules 64-md-raid.rules 

dracut/modules.d/90mdraid/module-setup.sh: inst_rules 64-md-raid.rules

Due to the mdraid rules, the actual dmraid device cannot be activated,
as a result the /dev/mapper links are pointing to wrong devices and the
boot fails.

Commenting out the line in dracut/modules.d/90dmraid/module-setup.sh
allows me to create bootable initramfs images.

Could it be, that the line in dracut/modules.d/90dmraid/module-setup.sh
was introduced just by a mistake or should i fill a bug report?

Cheers,
miroslav

-- 
Dr. Miroslav Shaltev
- Systemadministration -
Forschungszentrum L3S
Appelstrasse 9a
30167 Hannover
Fax:    +49 (0)511 762 - 17779
E-Mail: shaltev-ng3u6l8Qjkg@public.gmane.org
