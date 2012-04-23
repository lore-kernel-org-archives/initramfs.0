From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount option
Date: Mon, 23 Apr 2012 10:37:57 +0200
Message-ID: <4F9514E5.3010003@redhat.com>
References: <20120418222829.GG2224@redhat.com> <4F8FD3E5.90103@redhat.com>   <20120420135156.GE22419@redhat.com> <1335154319.18028.14.camel@cr0>  <4F95076A.9060504@redhat.com> <1335167619.18028.35.camel@cr0>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335167619.18028.35.camel@cr0>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 23.04.2012 09:53, schrieb Cong Wang:
> On Mon, 2012-04-23 at 09:40 +0200, Harald Hoyer wrote:
>>
>> Just activate the host-only mode "--hostonly" or "-H"
>>
> 
> Well, -H will set host-only mode for all dracut modules, but here we
> want to activate host-only mode _only_ for kernel-modules module.
> 
> For other dracut modules, we use --add to only specify those we need, as
> you can see from Vivek's output.
> 
> 

Why don't you want host-only mode for the other kernel modules?
