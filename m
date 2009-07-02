From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: initqueue
Date: Thu, 02 Jul 2009 14:51:59 +0200
Message-ID: <4A4CAD6F.6080201@suse.de>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4CAA92.9000401-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

Seewer Philippe wrote:
> Harald Hoyer wrote:
[ .. ]
>=20
> Please don't do that. That way we actually loose the benefit of doing=
 as
> much in parallel as possible. Instead please consider the patch below=
=2E
> I've been fiddling with this for a few weeks now. It basically replac=
es
> the current "wait-for-root" loop with a loop that queries the udev-qu=
eue
> and only exits if either root is available or all udev events have be=
en
> processed.
>=20
D'accord.

> It works, except if a udev event takes longer than the default 180s a=
s is
> the case with an unpatches cryptsetup and/or if we do user-interactio=
n
> from within udev which we shouldn't do anyway.
>=20
> Thank you,
> Philippe
>=20
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index 27c4dad..e14dc20 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -46,6 +46,11 @@ mkdir /dev/shm
> mkdir /dev/pts
> mount -t devpts -o gid=3D5,mode=3D620 /dev/pts /dev/pts >/dev/null 2>=
&1
>=20
> +# Set version specific udevadm options
> +UDEVVERSION=3D$(udevadm --version)
> +UDEVADMOPTS=3D""
> +[ $UDEVVERSION -ge 143 ] && UDEVADMOPTS=3D"--exit-if-exists=3D$NEWRO=
OT/proc"
> +
> # run scriptlets to parse the command line
> getarg 'rdbreak=3Dcmdline' && emergency_shell
> source_all cmdline
> @@ -76,7 +81,7 @@ source_all pre-trigger
>=20
> # then the rest
> udevadm trigger $udevtriggeropts  >/dev/null 2>&1
> -udevadm settle --timeout=3D30 >/dev/null 2>&1
> +udevadm settle --timeout=3D30 $UDEVADMOPTS >/dev/null 2>&1
>=20
> # pre-mount happens before we try to mount the root filesystem,
> # and happens once.
> @@ -86,18 +91,23 @@ getarg 'rdbreak=3Dmount' && emergency_shell
>=20
> # mount scripts actually try to mount the root filesystem, and may
> # be sourced any number of times. As soon as one suceeds, no more are
> sourced.
> -i=3D0
> -while :; do
> -    [ -d "$NEWROOT/proc" ] && break;
> -
> +while [ ! -d "$NEWROOT/proc" ] ; do
>     for f in /mount/*.sh; do
>        [ -x "$f" ] && . "$f";
>        [ "$ROOTFS_MOUNTED" ] && break;
>     done
>=20
> -    sleep 0.5
> -    i=3D$(($i+1))
> -    { flock -s 9 ; [ $i -gt 20 ] && emergency_shell; } 9>/.console_l=
ock
> +    # If the queue was empty and mount scripts failed as well, bail =
out
> +    [ -n "$EMPTYQUEUE" ] && break;
> +
> +    # Give udev events some time before we try anything. If the queu=
e
> +    # is empty, give mount-scripts another chance to get the root
> +    udevadm settle --timeout 5 $UDEVADMOPTS && EMPTYQUEUE=3D"1"
> +done
> +
> +# udev queue is empty, no root? Let the user figure this out
> +while [ ! -d "$NEWROOT/proc" ] ; do
> +    { flock -s 9 ; emergency_shell; } 9>/.console_lock
> done
>=20
> # pre pivot scripts are sourced just before we switch over to the new=
 root.
>=20
Ah, if it were so easy.

This approach work perfectly for any device which does synchronous scan=
ning.

=46or a device doing asynchronous scan you're out of luck here as the d=
evice
might start spitting out udev events at any time, even after the udev
queue is empty.

EG usb or qla2xxx have a habit of doing so. So either you implement
checks for each device (-type) which detects if the device is still
scanning or you indeed just wait until the device appears.

There actually is no problem with the latter, as all the design
goal here is to have _every_ device initialization in the background
/ asynchronously by udev.
So in foreground we indeed just have to wait for the device node
to appear. Even the udev queue check is pointless here; either
we have a device node, in which case we can continue regardless
of how many events are still in the udev queue;
or we don't have one, in which case it quite irrelevant if
udev has still events to process or not.
Think of multipath taking it's time to setup the multipath
environment; it's being notified by udev via a socket, so
udev is done with the event. But the device node is still
not present or not useable as multipath is still setting
up the topology.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
