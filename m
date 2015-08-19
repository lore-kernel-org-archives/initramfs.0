From: Giuseppe Scrivano <gscrivan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dracut --reproducible by default
Date: Wed, 19 Aug 2015 09:50:23 +0200
Message-ID: <87a8tnvhs0.fsf@foo.bar.baz>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

We are currently considering to feed Dracut with --reproducible in the
rpm-ostree[1] project when creating a new OStree[2] tree image.  In this
way there won't be need to store an additional file when the new initrd
file matches an older one.  Everything works very well (except the
additional step of providing a patched GNU cpio for now).

Reproducible images seem to make a lot of sense, also for users that
don't know about the --reproducible option.  Is there any reason why
this is not done by default?

Thanks,
Giuseppe

1) https://github.com/projectatomic/rpm-ostree
2) https://github.com/GNOME/ostree/
