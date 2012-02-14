From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] add net-lib, nfs-lib, url-lib, and img-lib
Date: Tue, 14 Feb 2012 12:38:01 -0500
Message-ID: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

This set of patches adds a bunch of "libraries" to dracut:
- net-lib adds some utility functions to module 40network
- nfs-lib provides the special nfs handling that was in 95nfs/nfsroot
- url-lib is a new module for handling http{s}/ftp URLs with curl
- img-lib is a new module for dealing with archives & fs images.

They might need tweaking for style/GPL headers/etc - just let me know and
I'll fix up the patches.

Only patch 3 and 5 change existing code - the rest should be very low-risk.

Patch 3 ports the existing nfsroot to nfs-lib. This is kind of a
proof-of-concept (look how short it is! whee!) but it *has not been tested*.
Feel free to take or leave that patch - but if someone could apply it and
help test it, I would be *very* thankful!

Patch 5 moves 90livenet to url-lib, and I *have* tested this to confirm that
it works.

If these are accepted, some next steps might be:
- move things out of dracut-lib.sh to net-lib or nfs-lib
  (wait_for_if_up, nfs_root_to_var, ip_to_var, etc.)
- add rpm/deb support to img-lib
  (is there a way to do optional dependencies, specified in dracut.conf?)
- add support for live "updates" images to livenet

Thanks for looking these over,

-w
