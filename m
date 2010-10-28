From: Steffen Maier <maier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: New rd.* namespace for dracut-008
Date: Thu, 28 Oct 2010 18:55:42 +0200
Message-ID: <4CC9AB0E.2040604@linux.vnet.ibm.com>
References: <4CC99414.5060607@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC99414.5060607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald, thanks for the update.
Just one quick question below.

On 10/28/2010 05:17 PM, Harald Hoyer wrote:
> I cleaned up the kernel command line parameters and moved them to the
> rd.* namespace. The deprecated options are supported until dracut-010
> and will be removed afterwards.
>
> Here is a list of options, which were used in dracut prior to
> version 008, and their new replacement.

> rd_CCW
> rd.ccw

> rd_DASD_MOD
> rd.dasd_mod.dasd

Is this a typo?
I'm wondering why the new one is not just "rd.dasd_mod".
Having a .dasd suffix is not necessary and users might mix it up with=20
rd.dasd which has both syntax and semamtics differently.

> rd_DASD
> rd.dasd

> rd_NO_ZFCPCONF
> rd.zfcp.conf=3D0
>
> rd_ZFCP
> rd.zfcp

Steffen

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
