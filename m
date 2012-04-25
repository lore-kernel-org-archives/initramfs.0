From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Wed, 25 Apr 2012 10:14:21 -0400
Message-ID: <20120425141421.GF12519@redhat.com>
References: <1335154319.18028.14.camel@cr0>
 <4F95076A.9060504@redhat.com>
 <1335167619.18028.35.camel@cr0>
 <4F9514E5.3010003@redhat.com>
 <20120423125449.GF8103@redhat.com>
 <1335237489.32756.8.camel@cr0>
 <20120424210224.GJ26708@redhat.com>
 <4F97C337.8040604@gmail.com>
 <20120425134606.GE12519@redhat.com>
 <4F9802CE.2030601@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F9802CE.2030601-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Apr 25, 2012 at 03:57:34PM +0200, Harald Hoyer wrote:
> Am 25.04.2012 15:46, schrieb Vivek Goyal:
> > On Wed, Apr 25, 2012 at 11:26:15AM +0200, Harald Hoyer wrote:
> > 
> > Hi Harald,
> > 
> > [..]
> >>      is_mpath() {
> >> -        [ -e /sys/dev/block/$1/dm/uuid ] || return 1
> >> -        [[ $(cat /sys/dev/block/$1/dm/uuid) =~ ^mpath- ]] && return 0
> >> +        local _dev
> >> +        _dev=${1##/dev/}
> >> +        [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
> >> +        [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ ^mpath- ]] && return 0
> > 
> > Will this work? _dev is device name (sda) and /sys/dev/block/ has links
> > based on device "maj:min". I applied this patch and ran dracut and I 
> > see that multipath module did not get included.
> > 
> > Thanks
> > Vivek
> 
> oh.. you are right:
> 
> diff --git a/modules.d/90multipath/module-setup.sh
> b/modules.d/90multipath/module-setup.sh
> index ae9ec59..2af112a 100755
> --- a/modules.d/90multipath/module-setup.sh
> +++ b/modules.d/90multipath/module-setup.sh
> @@ -12,7 +12,7 @@ check() {
> 
>      is_mpath() {
>          local _dev
> -        _dev=${1##/dev/}
> +        _dev=$(get_maj_min $1)
>          [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
>          [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ ^mpath- ]] && return 0
>          return 1
> diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
> index 34e101c..bfd9d73 100755
> --- a/modules.d/95iscsi/module-setup.sh
> +++ b/modules.d/95iscsi/module-setup.sh
> @@ -16,7 +16,7 @@ check() {
> 
>      is_iscsi() (
>          local _dev
> -        _dev=${1##/dev/}
> +        _dev=$(get_maj_min $1)
> 
>          [[ -L /sys/dev/block/$_dev ]] || return
>          cd "$(readlink -f /sys/dev/block/$_dev)"

Thanks Harald.

This fixes the issue for multipath.

For iscsi, I see that after this change iscsi module is included but iscsi
target bring up still does not happen so iscsi luns don't show up in second
kernel.

I think iscsi code might be assuing that we will pass some iscsi
parameters on command line but we don't have any information and we
don't pass anything. So iscsi module need save some files/state in
initramfs during build and bring up iscsi targets accordingly.

In RHEL6, during the block device stack traversal, I had saved the
target information in a file and packed that file in initramfs. And
then invoked code in initramfs to specifically bring up those luns.

I need to read up some code and also see if network modules are being
included or not and if networking is coming up or not before iscsi
can come up.

Thanks
Vivek
