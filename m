From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 41/42] 95rootfs-block: Correctly terminate commandline
 parameter
Date: Wed, 17 Dec 2014 11:57:28 +0100
Message-ID: <54916198.1060206@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de> <1418309193-11208-42-git-send-email-trenn@suse.de> <54915E9C.2050306@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54915E9C.2050306-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/17/2014 11:44 AM, Harald Hoyer wrote:
> I reverted this patch.
>=20
> $ ./dracut.sh -l --print-cmdline
> root=3DUUID=3Dd5e53483-30bc-4119-8c0c-841d47a2f76brootflags=3Drw,noat=
ime,compress=3Dlzo,ssd,discard,space_cache,autodefrag,inode_cacherootfs=
type=3Dbtrfs
>=20
> instead of:
>=20
> $ ./dracut.sh -l --print-cmdline
>  root=3DUUID=3Dd5e53483-30bc-4119-8c0c-841d47a2f76b
> rootflags=3Drw,noatime,compress=3Dlzo,ssd,discard,space_cache,autodef=
rag,inode_cache rootfstype=3Dbtrfs
>=20
> and also
>=20
> $ make testimage
> =85
>  *** Store current command line parameters ***
> Stored kernel commandline:
> root=3DUUID=3Dd5e53483-30bc-4119-8c0c-841d47a2f76brootflags=3Drw,noat=
ime,compress=3Dlzo,ssd,discard,space_cache,autodefrag,inode_cacherootfs=
type=3Dbtrfs
> =85
>=20
Any specific reason for this?
Errors, failures?

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
