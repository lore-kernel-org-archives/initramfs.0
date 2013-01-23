From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut-025
Date: Wed, 23 Jan 2013 16:12:07 +0100
Message-ID: <50FFFDC7.2000105@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to
this release.

The tarball can be found here:
	http://www.kernel.org/pub/linux/utils/boot/dracut/
	ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/

Git:
	git://git.kernel.org/pub/scm/boot/dracut/dracut.git
	http://git.kernel.org/pub/scm/boot/dracut/dracut.git
	https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Git Web:
	http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
	http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
	http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
	http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS

dracut-025
==========
- do not strip signed kernel modules
- add sosreport script and generate /run/initramfs/sosreport.txt
- make short uuid specification for allow-discards work
- turn off RateLimit for the systemd journal
- fixed MAC address assignment
- add systemd checkisomd5 service
- splitout drm kernel modules from plymouth module
- add 'swapoff' to initramfs to fix shutdown/reboot
- add team device support
- add pre-shutdown hook
- kill all processes in shutdown and report remaining ones
- "--device" changed to "--add-device" and "add_device=" added for conf files
- add memory usage trace to different hook points
- cope with optional field #7 in /proc/self/mountinfo
- lots of small bugfixes
