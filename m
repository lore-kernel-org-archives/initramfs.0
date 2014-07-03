From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] systemd: Optionally, include efivarsfs module
Date: Thu, 03 Jul 2014 09:22:16 +0200
Message-ID: <53B504A8.2040506@redhat.com>
References: <1402895624-20478-1-git-send-email-crrodriguez@opensuse.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402895624-20478-1-git-send-email-crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 16.06.2014 07:13, Cristian Rodr=EDguez wrote:
> It is, however not an error if this module can't be found.
> ---
>  modules.d/98systemd/module-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98system=
d/module-setup.sh
> index cf1b2e7..dd82ece 100755
> --- a/modules.d/98systemd/module-setup.sh
> +++ b/modules.d/98systemd/module-setup.sh
> @@ -21,6 +21,7 @@ depends() {
> =20
>  installkernel() {
>      instmods autofs4 ipv6
> +    instmods -s efivarfs
>  }
> =20
>  # called by dracut
>=20

Thanks! In dracut-038
