From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: New rd.* namespace for dracut-008
Date: Thu, 28 Oct 2010 17:17:40 +0200
Message-ID: <4CC99414.5060607@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I cleaned up the kernel command line parameters and moved them to the rd.* 
namespace. The deprecated options are supported until dracut-010 and will be 
removed afterwards.

   Here is a list of options, which were used in dracut prior to

        version 008, and their new replacement.



        rdbreak

            rd.break



        rd_CCW

            rd.ccw



        rdcopystate

            rd.copystate



        rd_DASD_MOD

            rd.dasd_mod.dasd



        rd_DASD

            rd.dasd



        rdinitdebug rdnetdebug

            rd.debug



        rd_NO_DM

            rd.dm=0



        rd_DM_UUID

            rd.dm.uuid



        rdblacklist

            rd.driver.blacklist



        rdinsmodpost

            rd.driver.post



        rdloaddriver

            rd.driver.pre



        rd_NO_FSTAB

            rd.fstab=0



        rdinfo

            rd.info



        check

            rd.live.check



        rdlivedebug

            rd.live.debug



        live_dir

            rd.live.dir



        liveimg

            rd.live.image



        overlay

            rd.live.overlay



        readonly_overlay

            rd.live.overlay.readonly



        reset_overlay

            rd.live.overlay.reset



        live_ram

            rd.live.ram



        rd_NO_CRYPTTAB

            rd.luks.crypttab=0



        rd_LUKS_KEYDEV_UUID

            rd.luks.keydev.uuid



        rd_LUKS_KEYPATH

            rd.luks.keypath



        rd_NO_LUKS

            rd.luks=0



        rd_LUKS_UUID

            rd.luks.uuid



        rd_LUKS_UUID

            rd.luks.uuid



        rd_NO_LVMCONF

            rd.lvm.conf



        rd_LVM_LV

            rd.lvm.lv



        rd_NO_LVM

            rd.lvm=0



        rd_LVM_SNAPSHOT

            rd.lvm.snapshot



        rd_LVM_SNAPSIZE

            rd.lvm.snapsize



        rd_LVM_VG

            rd.lvm.vg



        rd_NO_MDADMCONF

            rd.md.conf=0



        rd_NO_MDIMSM

            rd.md.imsm=0



        rd_NO_MD

            rd.md=0



        rd_MD_UUID

            rd.md.uuid



        rd_NFS_DOMAIN

            rd.nfs.domain



        rd_NO_PLYMOUTH

            rd.plymouth=0



        rd_retry

            rd.retry



        rdshell

            rd.shell



        rd_NO_SPLASH

            rd.splash



        rdudevdebug

            rd.udev.debug



        rdudevinfo

            rd.udev.info



        rd_NO_ZFCPCONF

            rd.zfcp.conf=0



        rd_ZFCP

            rd.zfcp
