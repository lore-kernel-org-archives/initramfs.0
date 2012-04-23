From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Mon, 23 Apr 2012 08:54:49 -0400
Message-ID: <20120423125449.GF8103@redhat.com>
References: <20120418222829.GG2224@redhat.com>
 <4F8FD3E5.90103@redhat.com>
 <20120420135156.GE22419@redhat.com>
 <1335154319.18028.14.camel@cr0>
 <4F95076A.9060504@redhat.com>
 <1335167619.18028.35.camel@cr0>
 <4F9514E5.3010003@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F9514E5.3010003-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Mon, Apr 23, 2012 at 10:37:57AM +0200, Harald Hoyer wrote:
> Am 23.04.2012 09:53, schrieb Cong Wang:
> > On Mon, 2012-04-23 at 09:40 +0200, Harald Hoyer wrote:
> >>
> >> Just activate the host-only mode "--hostonly" or "-H"
> >>
> > 
> > Well, -H will set host-only mode for all dracut modules, but here we
> > want to activate host-only mode _only_ for kernel-modules module.
> > 
> > For other dracut modules, we use --add to only specify those we need, as
> > you can see from Vivek's output.
> > 
> > 
> 
> Why don't you want host-only mode for the other kernel modules?

I think host-only should be reasonable but there should be scope for
further optimization. IIUC, host-only will try to include all the modules
which are needed to mount root and boot the machine. But in kdump, we
might not want to mount root at all. We just might want to dump vmcore
over NFS and reboot.

So the assumption that we will necessarily mount root is not valid in
kdump context. I am not sure how much memory saving this extra
optimization will lead to, but I will try passing -H and do some testing
and see how size is varying.

Thanks
Vivek
