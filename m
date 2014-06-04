From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: iBFT oddities
Date: Wed, 04 Jun 2014 09:52:34 +0200
Message-ID: <538ED042.8000904@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi all,

I'm trying to setup a machine with root on iSCSI via iBFT
(on SR-IOV, yay!).

But anyhow, I'll be setting 'ip=3Dibft' on the commandline as per=20
documentation and the iBFT settings are applied and everything is=20
nice and dandy.

It's only that dracut complains during boot:

Jun 03 16:28:11 localhost dracut-cmdline[80]: ibft
Jun 03 16:28:11 localhost dracut-cmdline[80]: Warning: Please supply=20
bootdev argument for multiple ip=3D lines
Jun 03 16:28:11 localhost dracut-cmdline[80]: Warning: Setting=20
bootdev to 'ibft0'

Looking closer, setting 'ip=3Dibft' triggers 'ibft_to_cmdline()',
which will add _another_ ip=3D argument to the dracut commandline.
And consequently parse_ip_opts() complains here.

While it's quite easy to fix (just ignore ip=3Dibft when checking for=20
duplicate ip arguments), I do wonder whether this is the correct way.

Thing is, 'ip=3Dibft' is not really an ip setting, but rather a marker=20
that iBFT should be evaluated.
As such, wouldn't 'rd.iscsi.firmware=3Dibft' be a more appropriate=20
setting?
Seeing that the ip argument is added to the commandline anyway,=20
having a duplicate 'ip=3Dibft' setting does look a bit odd.
And confuses the logic ...

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
