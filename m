From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: small updates for dmsquash-live module
Date: Mon,  1 Aug 2011 16:21:06 -0400
Message-ID: <1312230069-10674-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

These are just some smallish updates for dmsquash-live.

Patch 1/3 is just a few cleanups - inessential, but nice to have.

Patch 2/3 makes dmsquash-live-root determine the image type (i.e.
squashed or unsquashed) by mounting it and checking the filesystem
type, rather than requiring a specific filename. This is important for
the livenet module (which will be appearing in a later email).

Patch 3/3 is simple and useful - it adds a pre-pivot hook which will
copy any files found in /updates in the initramfs into the live
filesystem. This allows hotfixes to live images. Whee!

 modules.d/90dmsquash-live/apply-live-updates.sh |    7 ++++++
 modules.d/90dmsquash-live/dmsquash-live-root    |   27 ++++++++++++++--------
 modules.d/90dmsquash-live/module-setup.sh       |    1 +
 3 files changed, 25 insertions(+), 10 deletions(-)

-w
