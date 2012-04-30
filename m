From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Mon, 30 Apr 2012 11:07:35 -0400
Message-ID: <20120430150735.GG3693@redhat.com>
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

Harald, I saw these patches committed in master branch of fedora tree. Are
you planning to commit them for F17 too? They are not very intrusive
so it might not be a bad idea?  From my perspective, multipath kdump
support gets enabled in F17 and my future testing becomes easier.

Thanks
Vivek
