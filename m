From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: OverlayFS support for LiveOS
Date: Sat, 19 Dec 2015 19:51:37 -0800
Message-ID: <CAEcBt+XQd2aGRFrVkoAyEP9gjrkij1h9pX0VRaNXNrvshwnb4g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=PDBc1PYOs7jLgWl5ZkqXvgKcvRFOGPBCJYfpUTKY8sk=;
        b=E4djCEXlb7nS5SnaUta9LF3GekZzz+in7jQbxAPHnCy/7ZClIJgUlmi49xgTbU45dl
         6kxthIWl7qZW2uEMTBXhl7pERT9zw+QDlXJ2uqk3RPar9T9jfcApW4q2l3qO4iJrostY
         m3HzpIsKU6Zgwxf0yB6pwTrValyUJAwMISWTQxt7FFWhDpuQPnuutGRDe47W68Dennkn
         yXOiBXXWAsoXFYl2kH1270X/NWPEC/HlzPifKxNTHfri+IGj9lEnEjceUqkV6sh1yqrH
         eMDuawyzIwQlW6N4WuM9RoHi41e0IvCcG5BidVODXlDeMeRk99CDaPKXQeED6+/KhRk6
         dmmQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

See this pull request, https://github.com/haraldh/dracut/pull/107
and issue discussion, https://github.com/haraldh/dracut/issues/104

This may be suitable for rawhide testing, particularly with btrfs and
other filesystems.

Commit message:
Integrate the option to use an OverlayFS as the root filesystem
into the 90dmsquash-live module for testing purposes.

Tested primarily with transient, in-RAM overlay boots on vfat-
formatted Live USB devices, with persistent overlay directories
on ext4-formatted Live USB devices, and with embedded, persistent
overlay directories on vfat-formatted devices. (Persistent overlay
directories on a vfat-formatted device must be in an embedded
filesystem that supports the creation of trusted.* extended attributes,
and must provide valid d_type in readdir responses.) The
rd.live.overlay.readonly option to allow a persistent overlayfs to be
mounted read only through a higher level transient overlay directory
has been implemented through the multiple lower layers feature of
OverlayFS.

This implementation currently requires the enforcing=0 kernel command
line option. Further SELinux tuning may change this limitation.

To permit easier comparison of Device-mapper vs. OverlayFS performance,
the default transient dm overlay size has been adjusted up to 32 GiB.
A transient dm overlay is a sparse file in memory, so this does not
consume more RAM for legacy applications. It does permit a user to
use all of the available root filesystem storage, and fails gently
when it is consumed, as the available free root filesystem storage on
a typical LiveOS build is under a few GiB. Thus, when booted on other-
than-small RAM systems, the transient dm overlay should not overflow.

OverlayFS offers the potential to use all of the available free RAM,
or all of the available free disc storage on non-vfat-devices,
in its overlay, even beyond the root filesystem available space,
because the OverlayFS root filesystem is a union of directories on
two different partitions.
