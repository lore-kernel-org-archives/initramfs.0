From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] crypt: dropped plymouth --has-active-vt check on passwd
 prompt
Date: Fri, 12 Aug 2011 08:21:01 +0200
Message-ID: <4E44C64D.2020501@redhat.com>
References: <1309470560-16173-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1309470560-16173-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 30.06.2011 23:49, Amadeusz =C5=BBo=C5=82nowski wrote:
> As Ray Strode explains, plymouth --has-active-vt may fail if the user
> passes console=3DttyS0 or something other not corresponding to
> console=3Dtty0, because plymouth is outputing to the serial console a=
nd
> not a VT in this case.
> ---
>  modules.d/90crypt/crypt-lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt=
-lib.sh
> index 122d88e..3ef8482 100644
> --- a/modules.d/90crypt/crypt-lib.sh
> +++ b/modules.d/90crypt/crypt-lib.sh
> @@ -47,7 +47,7 @@ ask_for_password() {
> =20
>      { flock -s 9;
>          # Prompt for password with plymouth, if installed and runnin=
g.
> -        if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; th=
en
> +        if [ -x /bin/plymouth ]; then
>              /bin/plymouth ask-for-password \
>                  --prompt "$ply_prompt" --number-of-tries=3D$ply_trie=
s \
>                  --command=3D"$ply_cmd"

pushed
