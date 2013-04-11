From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] [99fs-lib] Create generic mount framework
Date: Thu, 11 Apr 2013 17:48:16 +0200
Message-ID: <5166DB40.7040108@redhat.com>
References: <1365694762-7806-1-git-send-email-devurandom@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365694762-7806-1-git-send-email-devurandom-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 11.04.2013 17:39, schrieb Dennis Schridde:
> * Utilises fstab.{early,late} files in /etc
> * Provides fs_add_mount function to mount in pre-mount (early) and pre-pivot (late) phases
> * Code to mount a fstab file is moved over from 95fstab-sys
> ---

Why not make use of fstab and fstab of the real root?

/etc/fstab in the initramfs == fstab.early
$NEWROOT/etc/fstab == fstab.late

??

In systemd we introduced "x-initrd.mount" as a mount option, to mark those mount
entries from $NEWROOT/etc/fstab to be mounted in pre-pivot.
