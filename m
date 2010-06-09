From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] 90crypt: 'crypto_LUKS' identifier corrected
Date: Wed, 09 Jun 2010 17:40:10 +0200
Message-ID: <4C0FB5DA.1070104@redhat.com>
References: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl>	<20100609103836.6d14d542@etiriah.ds.pg.gda.pl>	<20100609104031.01d37912@etiriah.ds.pg.gda.pl> <20100609110405.21e9a39a@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100609110405.21e9a39a-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/09/2010 11:04 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>   modules.d/90crypt/check |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
> index 07c53f9..7ba499a 100755
> --- a/modules.d/90crypt/check
> +++ b/modules.d/90crypt/check
> @@ -19,7 +19,7 @@ is_crypt() { [[ $(get_fs_type /dev/block/$1) =3D cr=
ypto_LUKS ]]; }
>   	check_block_and_slaves is_crypt "$rootdev" || exit 1
>       else
>   	# root is not on a block device, use the shotgun approach
> -	blkid | grep -q crypt_LUKS || exit 1
> +	blkid | grep -q 'crypto\?_LUKS' || exit 1
>       fi
>   }
>

pushed
