From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] btrfs improvements, in-initramfs dmsquash-live images
Date: Tue,  8 Mar 2011 18:35:10 -0500
Message-ID: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi folks,

This patch series is the result of my attempt to convert anaconda (the
Fedora installer) into a btrfs-based, dmsquash-live image that uses dracut
to start up.

The first 4 patches are just bugfixes (1, 2) and minor tweaks that should
not change existing behavior (3, 4). Patch 5 and 6 improve btrfs handling and
add support for images named 'btrfs.img' to dmsquash-live-root.

The final patch is the interesting one. It adds code to dmsquash-live to
allow live systems that run completely from an image within the initramfs.
(This happens to be how anaconda runs right now - as a 360MB initramfs.)

For this to work you need to pass:
   root=live:/path/to/*{squashfs,ext3fs,btrfs}.img
on the boot commandline. (And, obviously, that file needs to exist inside
initramfs.)

Doing this lets us keep the anaconda runtime compressed in RAM while the
installation process runs. With our current images we run out of RAM on
systems with <= 512MB; using ext3/btrfs inside squashfs fixes that.

Feedback welcomed. Thanks.

 dracut-functions                                   |    4 +-
 modules.d/90btrfs/80-btrfs.rules                   |    2 +-
 modules.d/90btrfs/module-setup.sh                  |   10 ++++--
 modules.d/90dm/module-setup.sh                     |    3 --
 modules.d/90dmraid/module-setup.sh                 |    3 --
 .../90dmsquash-live/dmsquash-live-genrules.sh      |   12 +++++-
 modules.d/90dmsquash-live/dmsquash-live-root       |   38 +++++++++++++------
 modules.d/90dmsquash-live/module-setup.sh          |    4 ++
 modules.d/90dmsquash-live/parse-dmsquash-live.sh   |    2 +
 modules.d/90lvm/module-setup.sh                    |    3 --
 10 files changed, 52 insertions(+), 29 deletions(-)

-w
