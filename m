From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] kernel-modules: inst modules.builtin if there's no modules.builtin.bin
Date: Thu, 28 Apr 2011 15:45:47 +0200
Message-ID: <4DB96F8B.7080505@redhat.com>
References: <1303486991-8133-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303486991-8133-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 22.04.2011 17:43, schrieb Amadeusz =C5=BBo=C5=82nowski:
> Also report failure if none of them exist.
> ---
>   modules.d/90kernel-modules/module-setup.sh |   11 ++++++++++-
>   1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/9=
0kernel-modules/module-setup.sh
> index 5f0e4a7..5764bf5 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -46,5 +46,14 @@ install() {
>       dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
>       inst_hook cmdline 01 "$moddir/parse-kernel.sh"
>       inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
> -    inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/module=
s.builtin.bin"
> +
> +    local f
> +
> +    for f in modules.builtin.bin modules.builtin; do
> +        [[ $srcmods/$f ]]&&  inst "$srcmods/$f" "/lib/modules/$kerne=
l/$f" \
> +&&  break
> +    done || {
> +        dfatal "No modules.builtin.bin and modules.builtin found!"
> +        return 1
> +    }
>   }

pushed! Thank you!
