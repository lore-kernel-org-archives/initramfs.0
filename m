From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: SUSE mkinitrd wrapper
Date: Thu, 28 Nov 2013 14:36:41 +0100
Message-ID: <529746E9.4040708@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Harald,

I've updated the current 'mkinitrd-dracut.sh' script to function as
a wrapper to the old SUSE mkinitrd script.
However, as some arguments clash between SUSE mkinitrd and
mkinitrd-dracut.sh I've put them into a separate script,
mkinitrd-suse.sh.

What do you prefer? Having two separate scripts?
As I'm not sure if anybody is actually using the
'mkinitrd-dracut.sh' script I could as well merge the changes into
that one.

Just tell me what you prefer.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
