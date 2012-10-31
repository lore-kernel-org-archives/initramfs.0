From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dmraid/lvm/mdraid activation logic fix.
Date: Wed, 31 Oct 2012 10:55:41 +0800
Message-ID: <5090932D.4010607@redhat.com>
References: <1350907147-26720-1-git-send-email-chaowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350907147-26720-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/22/2012 07:59 PM, WANG Chao wrote:
> Current dmraid/lvm/mdraid activation logic looks like a mess.
>
> Only activate dmraid/lvm/mdraid under any of the following conditions:
> 1. User specify rd.dm.uuid/rd.md.uuid/rd.lvm.{vg,lv} on the cmdline.
> 2. rd.dm/rd.md/rd.lvm != 0 and rd.auto=1
>
> On the contrary, disable activation when !(cond 1 or cond 2).
>
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   modules.d/90dmraid/parse-dm.sh | 13 +++++--------
>   modules.d/90lvm/parse-lvm.sh   |  5 +++--
>   modules.d/90mdraid/parse-md.sh |  3 ++-
>   3 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/modules.d/90dmraid/parse-dm.sh b/modules.d/90dmraid/parse-dm.sh
> index 76dfb5d..4bc903c 100755
> --- a/modules.d/90dmraid/parse-dm.sh
> +++ b/modules.d/90dmraid/parse-dm.sh
> @@ -2,8 +2,11 @@
>   # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
>   # ex: ts=8 sw=4 sts=4 et filetype=sh
>   # nodmraid for anaconda / rc.sysinit compatibility
> -if ! getargbool 1 rd.dm -d -n rd_NO_DM || getarg "rd.dm=0" -d nodmraid; then
> -    info "rd.dm=0: removing DM RAID activation"
> +
> +DM_RAIDS=$(getargs rd.dm.uuid -d rd_DM_UUID=)
> +
> +if [ -z "$DM_RAIDS" ] && \
> +    (! getargbool 0 rd.auto || ! getargbool 1 rd.dm -d -n rd_NO_DM -d -n nodmraid); then
>       udevproperty rd_NO_DM=1
>   fi
>
> @@ -16,9 +19,3 @@ if  ! command -v mdadm >/dev/null || ! getargbool 1 rd.md.ddf -n rd_NO_MDDDF -n
>       info "rd.md.ddf=0: no MD RAID for SNIA ddf raids"
>       udevproperty rd_NO_MDDDF=1
>   fi
> -
> -DM_RAIDS=$(getargs rd.dm.uuid -d rd_DM_UUID=)
> -
> -if [ -z "$DM_RAIDS" ] && ! getargbool 0 rd.auto; then
> -    udevproperty rd_NO_DM=1
> -fi
> diff --git a/modules.d/90lvm/parse-lvm.sh b/modules.d/90lvm/parse-lvm.sh
> index 3e6b371..655d6c6 100755
> --- a/modules.d/90lvm/parse-lvm.sh
> +++ b/modules.d/90lvm/parse-lvm.sh
> @@ -1,14 +1,15 @@
>   #!/bin/sh
>   # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
>   # ex: ts=8 sw=4 sts=4 et filetype=sh
> +
>   if [ -e /etc/lvm/lvm.conf ] && ! getargbool 1 rd.lvm.conf -d -n rd_NO_LVMCONF; then
>       rm -f /etc/lvm/lvm.conf
>   fi
>
>   LV_DEVS="$(getargs rd.lvm.vg -d rd_LVM_VG=) $(getargs rd.lvm.lv -d rd_LVM_LV=)"
>
> -if ! getargbool 1 rd.lvm -d -n rd_NO_LVM \
> -    || ( [ -z "$LV_DEVS" ] && ! getargbool 0 rd.auto ); then
> +if [ -z "$LV_DEVS" ] && \
> +    (! getargbool 0 rd.auto || ! getargbool 1 rd.lvm -d -n rd_NO_LVM ); then
>       info "rd.lvm=0: removing LVM activation"
>       rm -f /etc/udev/rules.d/64-lvm*.rules
>   else
> diff --git a/modules.d/90mdraid/parse-md.sh b/modules.d/90mdraid/parse-md.sh
> index 2de435b..80a19bc 100755
> --- a/modules.d/90mdraid/parse-md.sh
> +++ b/modules.d/90mdraid/parse-md.sh
> @@ -4,7 +4,8 @@
>
>   MD_UUID=$(getargs rd.md.uuid -d rd_MD_UUID=)
>
> -if ( ! [ -n "$MD_UUID" ] && ! getargbool 0 rd.auto ) || ! getargbool 1 rd.md -d -n rd_NO_MD; then
> +if [ -z "$MD_UUID" ] && \
> +    (! getargbool 0 rd.auto || ! getargbool 1 rd.md -d -n rd_NO_MD); then
>       info "rd.md=0: removing MD RAID activation"
>       udevproperty rd_NO_MD=1
>   else
>

Hi, Harald

What do you think of this patch?

And also kdump need this patch. cc4037d explains why we need override 
rd.dm/rd.md if rd.dm.uuid/rd.md.uuid is provided. And e064127 which 
introduces rd.auto breaks the rules.

Thanks,
WANG Chao
