From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 033
Date: Thu, 12 Sep 2013 15:06:34 +0200
Message-ID: <5231BC5A.1040502@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here comes a new dracut version. Thanks to all who have contributed to this release.

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




dracut-033
==========
- improved hostonly device recognition
- improved hostonly module recognition
- add dracut.css for dracut.html
- do not install udev rules from /etc in generic mode
- fixed LABEL= parsing for swap devices
- fixed iBFT network setup
- url-lib.sh: handle 0-size files with curl
- dracut.asc: document debugging dracut on shutdown
- if rd.md=0, use dmraid for imsm and ddf
- skip empty dracut modules
- removed caching of kernel cmdline
- fixed iso-scan, if the loop device driver is a kernel module
- bcache: support new blkid
- fixed ifup udev rules
- ifup with dhcp, if no "ip=" specified for the interface
