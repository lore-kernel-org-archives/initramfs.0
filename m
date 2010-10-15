From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] suppress modprobe errors on builtins (credits to
 Kay Sievers)
Date: Fri, 15 Oct 2010 09:53:55 +0200
Message-ID: <4CB80893.4000603@redhat.com>
References: <1286991554-3715-1-git-send-email-aidecoe@aidecoe.name> <1286991554-3715-2-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286991554-3715-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/13/2010 07:39 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Install /lib/modules/$kv/modules.builtin.bin to suppress modprobe err=
or
> messages saying module was not found, while it's built-in.
>
> Credits go to Kay Sievers who enlighten us about meaning of this cool
> file.
> ---
>   modules.d/90kernel-modules/install |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-=
modules/install
> index 9810d12..863ffac 100755
> --- a/modules.d/90kernel-modules/install
> +++ b/modules.d/90kernel-modules/install
> @@ -4,3 +4,4 @@
>   [ -f /etc/modprobe.conf ]&&  dracut_install /etc/modprobe.conf
>   dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
>   inst_hook cmdline 01 "$moddir/parse-kernel.sh"
> +inst "$srcmods/modules.builtin.bin"

pushed
