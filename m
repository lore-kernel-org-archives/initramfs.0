From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] crypt: Skip /etc/crypttab if not present
Date: Wed, 31 Jul 2013 16:02:32 +0200
Message-ID: <51F918F8.7080201@redhat.com>
References: <1374787724-27608-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374787724-27608-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/25/2013 11:28 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Prevents following error message:
>=20
> I: *** Including module: crypt ***
> /usr/lib/dracut/modules.d/90crypt/module-setup.sh: line 31: /etc/cryp=
ttab: No such file or directory
> ---
>  modules.d/90crypt/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/mo=
dule-setup.sh
> index 639a77f..6b32b6a 100755
> --- a/modules.d/90crypt/module-setup.sh
> +++ b/modules.d/90crypt/module-setup.sh
> @@ -57,7 +57,7 @@ install() {
>          inst_hook cleanup 30 "$moddir/crypt-cleanup.sh"
>      fi
> =20
> -    if [[ $hostonly ]]; then
> +    if [[ $hostonly ]] && [[ -f /etc/cryptab ]]; then
>          # filter /etc/crypttab for the devices we need
>          while read _mapper _dev _rest; do
>              [[ $_mapper =3D \#* ]] && continue
>=20

pushed, thanks!
