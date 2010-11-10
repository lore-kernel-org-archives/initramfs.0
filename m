From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Allow fstab-based remount to be controlled by modules
Date: Wed, 10 Nov 2010 15:32:06 +0100
Message-ID: <4CDAACE6.8040108@redhat.com>
References: <20101108194128.EBFEB9D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101108194128.EBFEB9D401B-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/08/2010 08:41 PM, Daniel Drake wrote:
> OLPC would like to be able to disable this behaviour through
> a custom dracut module. Add a "no_fstab_remount" flag which can be
> set by modules that want to disable this functionality.
>
> (Background: having the correct rootfs info in /etc/fstab is a bit of a
>   challenge for OLPC, because this info is not known at build time.)
> ---
>   modules.d/95rootfs-block/mount-root.sh |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
> index ff64209..7602731 100755
> --- a/modules.d/95rootfs-block/mount-root.sh
> +++ b/modules.d/95rootfs-block/mount-root.sh
> @@ -73,6 +73,7 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
>       rootopts=
>       if getargbool 1 rd.fstab -n rd_NO_FSTAB \
>           &&  ! getarg rootflags \
> +&&  [ -z "$no_fstab_remount" ] \
>           &&  [ -f "$NEWROOT/etc/fstab" ] \
>           &&  ! [ -L "$NEWROOT/etc/fstab" ]; then
>           # if $NEWROOT/etc/fstab contains special mount options for

Why don't you reuse rd.fstab then? You could add preset kernel cmdline options 
in /etc/cmdline in the initramfs.

Just add for your dracut module in install:

mkdir -p ${initdir}/etc
echo " rd.fstab=0 " >> ${initdir}/etc/cmdline
