From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 040
Date: Fri, 24 Oct 2014 14:03:29 +0200
Message-ID: <544A4011.8030400@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to this
release.

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

dracut-040
==========
- fixed dracut module dependency checks
- fixed test suite

dracut-039
==========
- DRACUT_PATH can now be used to specify the PATH used by dracut
  to search for binaries instead of the default
  /usr/sbin:/sbin:/usr/bin:/bin
  This should be set in the distribution config file
  /usr/lib/dracut/dracut.conf.d/01-dist.conf
- add "--loginstall <DIR>" and loginstall="<DIR>" options
  to record all files, which are installed from the host fs
- "rd.writable.fsimg" - support for read/write filesystem images
- "rd.route" kernel command line parameter added
- "--install-optional" and install_optional_items added
- find plymouth pkglibdir on debian
- torrent support for live images
  root=live:torrent://example.com/liveboot.img.torrent
  and generally added as a download handler
- disable microcode, if the kernel does not support it
- speed up ldconfig_paths()
- more ARM modules
- fixed inst*() functions and "-H" handling
- fixed bridge setup
- added --force-drivers parameter and force_drivers=+ config option
  to enforce driver loading at early boot time
- documented "iso-scan/filename" usage in grub
- various bugfixes

