From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH 1/2] [99fs-lib] Create generic mount framework
Date: Thu, 11 Apr 2013 18:10:54 +0200
Message-ID: <1645019.IW4GTDGkzb@ernie>
References: <1365694762-7806-1-git-send-email-devurandom@gmx.net> <5166DB40.7040108@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4884982.yzk5CM8dtB"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5166DB40.7040108-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart4884982.yzk5CM8dtB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 11. April 2013, 17:48:16 schrieb Harald Hoyer:
> Am 11.04.2013 17:39, schrieb Dennis Schridde:
> > * Utilises fstab.{early,late} files in /etc
> > * Provides fs_add_mount function to mount in pre-mount (early) and
> > pre-pivot (late) phases * Code to mount a fstab file is moved over from
> > 95fstab-sys
> > ---
> 
> Why not make use of fstab and fstab of the real root?
> 
> /etc/fstab in the initramfs == fstab.early
> $NEWROOT/etc/fstab == fstab.late
I want to mount depending on the cmdline arguments of the kernel.

Basically, what I need is a way to guarantee certain devices/directories to be 
mounted before dracut tries to mount the rootfs.

Also, the mountpoints are inside the initramfs, not inside the rootfs. So 
having them in the rootfs' fstab (when the mountpoints do not exist there), 
seems wrong.

For testing it was extremely helpful that I could provide these devices on the 
cmdline, because the initramfs takes quite a while to build on my machines, so 
replacing a file inside them each time I tried to get the path right would 
have been cumbersome.

> In systemd we introduced "x-initrd.mount" as a mount option, to mark those
> mount entries from $NEWROOT/etc/fstab to be mounted in pre-pivot.

I assume there is nothing (yet) that mounts entries before the rootfs gets 
mounted?

--Dennis
--nextPart4884982.yzk5CM8dtB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlFm4JIACgkQjqfyF1DtJW5ATgCghXemtPoGJjxp0IdE1FXYl1St
3SQAnRsZnAWz4C2s2Z5CifmFcmLo1A+z
=a7g2
-----END PGP SIGNATURE-----

--nextPart4884982.yzk5CM8dtB--
