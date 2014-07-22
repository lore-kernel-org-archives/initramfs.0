From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] inst_simple doesn't take '-H' parameter
Date: Tue, 22 Jul 2014 14:29:10 +0200
Message-ID: <53CE5916.3080707@redhat.com>
References: <1405929291-6523-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405929291-6523-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 21.07.2014 09:54, Amadeusz =C5=BBo=C5=82nowski wrote:
> It was introduced in commit 5a5758.
> ---
>  modules.d/90lvm/module-setup.sh  | 2 +-
>  modules.d/95zfcp/module-setup.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module=
-setup.sh
> index 2f2b64c..5073082 100755
> --- a/modules.d/90lvm/module-setup.sh
> +++ b/modules.d/90lvm/module-setup.sh
> @@ -59,7 +59,7 @@ install() {
> =20
>      if [[ $hostonly ]] || [[ $lvmconf =3D "yes" ]]; then
>          if [ -f /etc/lvm/lvm.conf ]; then
> -            inst_simple -H /etc/lvm/lvm.conf
> +            inst_simple /etc/lvm/lvm.conf
>              # FIXME: near-term hack to establish read-only locking;
>              # use command-line lvm.conf editor once it is available
>              sed -i -e 's/\(^[[:space:]]*\)locking_type[[:space:]]*=3D=
[[:space:]]*[[:digit:]]/\1locking_type =3D 4/' ${initdir}/etc/lvm/lvm.c=
onf
> diff --git a/modules.d/95zfcp/module-setup.sh b/modules.d/95zfcp/modu=
le-setup.sh
> index 9526caa..b96ccd2 100755
> --- a/modules.d/95zfcp/module-setup.sh
> +++ b/modules.d/95zfcp/module-setup.sh
> @@ -31,6 +31,6 @@ install() {
>      inst_rules 56-zfcp.rules
> =20
>      if [[ $hostonly ]]; then
> -        inst_simple -H /etc/zfcp.conf
> +        inst_simple /etc/zfcp.conf
>      fi
>  }
>=20

Thanks! Fixed in another way.
