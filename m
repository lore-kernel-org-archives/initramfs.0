From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] allow network setup without netroot
Date: Wed, 11 Jan 2012 12:48:29 -0500
Message-ID: <1326304109-32652-3-git-send-email-wwoods@redhat.com>
References: <1326304109-32652-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326304109-32652-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Currently, network configuration arguments are ignored *unless* the root
device is a network device. But there are some cases where you might
want to set up the network even though you have a non-network root
device (e.g. to fetch updates from the network for a livecd image).

With this patch you can set "netroot=no", which will cause dracut to set
up the network according to your other boot arguments but not attempt to
set up a network root device.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/netroot |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 9d996cc..eba269a 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -13,11 +13,12 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 [ ! -e /tmp/net.$1.up ] && exit 1
 
 # There's no sense in doing something if no (net)root info is available
-# or root is already there
+# or root is already there - or if we're specifially told not to
 [ -e /tmp/root.info ] || exit 1
 . /tmp/root.info
 [ -d $NEWROOT/proc ] && exit 0
 [ -z "$netroot" ] && exit 1
+[ "$netroot" = "no" ] && exit 0
 
 # Let's see if we have to wait for other interfaces
 # Note: exit works just fine, since the last interface to be
-- 
1.7.7.5
