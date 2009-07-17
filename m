From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCEMENT] dracut-0.5
Date: Fri, 17 Jul 2009 16:38:11 +0200
Message-ID: <4A608CD3.7070107@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

What's new in dracut-0.5:
=========================

- more generic (all plymouth modules, all keyboards, all console fonts)
- more kernel command line parameters (see also man dracut(8))
- a helper tool, which generates the kernel command line (dracut-gencmdline)

for my machine this looks like this:
# /sbin/dracut-gencmdline
rd_DM_UUID=nvidia_dddhfead 
rd_LUKS_UUID=luks-227fe0ce-7e8c-453a-823f-d5bf34ca1da3 rd_LVM_VG=VolGroup00 
KEYBOARDTYPE=pc KEYTABLE=de-latin1 SYSFONT=latarcyrheb-sun16 LANG=en_US.UTF-8

If you have Fedora and encrypted partitions you should at least set "KEYTABLE" 
to have the correct keyboard setting.

rd_DM_UUID, rd_LUKS_UUID, rd_MD_UUID help you, if dracut does more than you want 
in its automatic mode. So if you want to be more specific on what dracut is 
allowed to assemble, uncrypt etc. just specify the exact parameters.

For those with an Intel fake software raid onboard (imsm/isw), you might not 
want MD handle those, but fallback to the old behaviour with DM. To do so add
rd_NO_MDIMSM to the kernel command line.


Debugging
=========

Create your image with the debug module:

# dracut -a debug /boot/test-$(uname -r) $(uname -r)

Add "rdshell" to the kernel command line, remove "rhgb" and "quiet" and boot the 
image.

Once you are dropped to a shell do:

# dmesg|grep dracut

Add the output and your kernel command line to the bug report.

see also: https://fedoraproject.org/wiki/Dracut/Debugging


New kernel command line parameters:
===================================

I18N
        e.g. LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 
KEYTABLE=de-latin1-nodeadkeys

        KEYBOARDTYPE=sun|pc
               will be written to /etc/sysconfig/keyboard in the initramfs

        KEYTABLE=<keytable filename>
               will be written to /etc/sysconfig/keyboard in the initramfs

        SYSFONT= Console font
               will be written to /etc/sysconfig/i18n in the initramfs

        SYSFONTACM= Unicode font map
               will be written to /etc/sysconfig/i18n in the initramfs

        UNIMAP= Unicode font map
               will be written to /etc/sysconfig/i18n in the initramfs

        LANG=<locale>
               will be written to /etc/sysconfig/i18n in the initramfs

Bootsplash - plymouth
        rd_plytheme=<theme name>
               specify the plymouth bootsplash theme (fallback is text)

LVM
        rd_NO_LVM
               disable LVM detection

        rd_LVM_VG=<volume group name>
               only activate the volume groups with the given name

crypto LUKS
        rd_NO_LUKS
               disable crypto LUKS detection

        rd_LUKS_UUID=<luks uuid>
               only activate the LUKS partitions with the given UUID

MD
        rd_NO_MD
               disable MD RAID detection

        rd_NO_MDIMSM
               no MD RAID for imsm/isw raids, use dmraid instead

        rd_MD_UUID=<md uuid>
               only activate the raid sets with the given UUID

DMRAID
        rd_NO_DM
               disable DM RAID detection

        rd_DM_UUID=<dmraid uuid>
               only activate the raid sets with the given UUID
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
