From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] add --tmpdir option to cmd line args and tmpdir to
 config file
Date: Mon, 26 Mar 2012 14:42:04 +0200
Message-ID: <4F70641C.6060801@redhat.com>
References: <1332764916-22282-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332764916-22282-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 26.03.2012 14:28, schrieb Amadeusz =C5=BBo=C5=82nowski:
> Default temporary directory used by Dracut is /var/tmp, but users mig=
ht
> want to change it to /tmp.
> ---
>  dracut.conf |    2 ++
>  dracut.sh   |    9 +++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/dracut.conf b/dracut.conf
> index a502066..1ee563e 100644
> --- a/dracut.conf
> +++ b/dracut.conf
> @@ -38,3 +38,5 @@ lvmconf=3D"yes"
> =20
>  # inhibit installation of any fsck tools
>  #nofscks=3D"yes"
> +
> +tmpdir=3D/tmp

pushed, but commented in the line above...
