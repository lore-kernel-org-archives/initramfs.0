From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Multithreaded programs crashing due to libgcc_s missing
Date: Fri, 06 Jun 2014 16:58:47 +0200
Message-ID: <5391D727.5020907@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Harald,

I've just uncovered a rather nasty issue with dracut, where for no=20
apparent reason a (multithreaded) program was crashing.
Reason being here that libpthread _requires_ libgcc_s when any=20
program is using 'pthread_cancel'. When the library isn't present
any of those calls will generate a SIGABRT.
Nasty.

Best would be to pull libgcc_s in always when libpthread is=20
required. But that would be some library detection magic.
Can you fix this up?

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
