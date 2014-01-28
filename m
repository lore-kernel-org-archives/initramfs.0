From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] systemd: ensure autofs4 and ipv6 are included
Date: Tue, 28 Jan 2014 15:42:11 +0100
Message-ID: <52E7C1C3.40507@redhat.com>
References: <1387165258-10335-1-git-send-email-crrodriguez@opensuse.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387165258-10335-1-git-send-email-crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/16/2013 04:40 AM, Cristian Rodr=EDguez wrote:
> Systemd tries to load this modules very early.
> Even though they are not strictly required it it is a good
> thing to have them around.
> ---
>  modules.d/98systemd/module-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98system=
d/module-setup.sh
> index 748e25b..eb58158 100755
> --- a/modules.d/98systemd/module-setup.sh
> +++ b/modules.d/98systemd/module-setup.sh
> @@ -182,6 +182,7 @@ install() {
>      inst_script "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
> =20
>      inst_rules 99-systemd.rules
> +    instmods autofs4 ipv6
> =20
>      for i in \
>          emergency.target \
>=20

Thanks! Pushed.
