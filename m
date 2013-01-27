From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [Fedora-livecd-list] livecd-iso-to-disk and persistent issues
Date: Sun, 27 Jan 2013 14:47:17 -0500
Message-ID: <CAEcBt+X6SQJ9JUo-KgeMv7TeXVYwoMKUaF=Mkvcmz41Yya5afQ@mail.gmail.com>
References: <CABkMX_Ow6DBout8hngDF0Bd1U06OhMc4L9UyR9XKvXhhrGnUzg@mail.gmail.com>
 <CAEcBt+U0-oZBkxTt3jkdLJi2pvFF0-YaRFGFsFTYHnLu9oSe6A@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=oeK18XTXsrUXcVndJEQ29LK7JmGKOAQA/Yvg1E41I5Y=;
        b=ycyX9VZYRg3nOMer1Qhm23UvME//QGS87ZhIjwXKgOoqWZwibIdThHRKoH7bISKmcm
         sWv2eYKNC9YxHqIkTNdooi/6VYb0URQoQZ2BPpxTa9LNpNTORwVVq9UxEU820kLjyu6a
         R1CZXbC59R1E1dz2g6TwFz2WsBkjbeAM3v0SljBKJEWjaTzVK1XASHf++LCimJLmfpHo
         CGoivpq/iUbmFuN5M3uY+eCAvOauIWzLgyz7mRMAQ+M1IyvX7anX2lZJpVU7l/vo5IxG
         U++3FDEBmdeXpI6UPa5DQZcDslRL+f2GQy6HCksTtntwy+ZfBol/pVDkTOkdMnXbVS9P
         Rrcg==
In-Reply-To: <CAEcBt+U0-oZBkxTt3jkdLJi2pvFF0-YaRFGFsFTYHnLu9oSe6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Jan 9, 2013 at 2:32 AM, Ronen B <bronen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi,
> I would like to use the --overlay-size-mb parameter to make a one time chance and than lock the image.
> In other words, i want to boot the image that is placed on a SD card to make some changes in the OS (on the first boot) and then lock it so no other changes can be made in further boots.
> Any idea based on the --overlay-size-mb parameter would be appreciate (including  boot parameters, kernel tweaks and so on...)
>
> Thanks
> Ronen



The boot parameter rd.live.overlay.readonly would seem to fit your
need, but with it, a Fedora LiveOS image fails to boot completely to a
graphical desktop.

The following patch to /usr/sbin/dmsquash-live-root in the initramfs
achieves your objective:

commit 8850fc92a9b7eb9a6f0c20d6971094668493aea1
Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
Date:   Sat Jan 26 15:09:12 2013 -0500

    Provide devices to enable booting with rd.live.overlay.readonly=1

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index f302d44..0b1ed20 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -110,18 +110,34 @@ do_live_overlay() {
         umount -l /run/initramfs/overlayfs || :
     fi

-    if [ -z "$setup" ]; then
-        if [ -n "$devspec" -a -n "$pathspec" ]; then
+    if [ -z "$setup" -o -n "$readonly_overlay" ]; then
+        if [ -n "$setup" ]; then
+            warn "Using temporary overlay."
+        elif [ -n "$devspec" -a -n "$pathspec" ]; then
             warn "Unable to find persistent overlay; using temporary"
             sleep 5
         fi

         dd if=/dev/null of=/overlay bs=1024 count=1
seek=$((512*1024)) 2> /dev/null
-        losetup $OVERLAY_LOOPDEV /overlay
+        if [ -n "$setup" -a -n "$readonly_overlay" ]; then
+            RO_OVERLAY_LOOPDEV=$( losetup -f )
+            losetup $RO_OVERLAY_LOOPDEV /overlay
+        else
+            losetup $OVERLAY_LOOPDEV /overlay
+        fi
     fi

     # set up the snapshot
-    echo 0 `blockdev --getsz $BASE_LOOPDEV` snapshot $BASE_LOOPDEV
$OVERLAY_LOOPDEV p 8 | dmsetup create $readonly_overlay live-rw
+    sz=$(blockdev --getsz $BASE_LOOPDEV)
+    if [ -n "$readonly_overlay" ]; then
+        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 |
dmsetup create $readonly_overlay live-ro
+        base="/dev/mapper/live-ro"
+        over=$RO_OVERLAY_LOOPDEV
+    else
+        base=$BASE_LOOPDEV
+        over=$OVERLAY_LOOPDEV
+    fi
+    echo 0 $sz snapshot $base $over p 8 | dmsetup create live-rw
 }

 # live cd helper function

(Here are some instructions for changing files in the initramfs,
http://gyanip.blogspot.com/2010/12/procedure-to-insert-module-into-initrd.html
that I found helpful.)

Alternatively, you could merge the changes in your overlay with the
script on this wiki page:
https://fedoraproject.org/wiki/LiveOS_image#Merge_overlay_into_new_image

Following the merge, if the overlay file in the USB/SD device
filesystem at /LiveOS/overlay-LIVE-xxxx-xxxx is deleted or renamed, a
normal boot of the device will fail to find it and will generate a
temporary overlay for that single, non-persistent boot.

If you need to distribute your customized image, the edit-livecd
script of the the livecd-tools package was designed for rebuilding an
install .iso file from a customized image.

The edit-livecd script is behind on maintenance though and fails.

The editliveos.py script is a replacement available here,
http://git.sugarlabs.org/~FGrose/soas/sugar-clone-extensions/trees/master/editliveos

editliveos.py will run in a folder that also contains the fs.py,
live.py, creator.py, and util.py files, which have been modified to
support editliveos.py. (livecd-tools need not be installed.)

For instructions, run editliveos.py --help, or see this wiki section
(expand the [show] frame link),
http://wiki.sugarlabs.org/go/Sugar_on_a_Stick/Sugar_Clone#editliveos.help

         --Fred
