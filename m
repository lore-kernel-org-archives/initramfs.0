From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Mon, 23 Apr 2012 21:38:38 -0400
Message-ID: <20120424013838.GC22525@redhat.com>
References: <20120418222829.GG2224@redhat.com>
 <4F8FD3E5.90103@redhat.com>
 <20120420135156.GE22419@redhat.com>
 <1335154319.18028.14.camel@cr0>
 <4F95076A.9060504@redhat.com>
 <20120423151711.GD15561@redhat.com>
 <4F957F4A.6090808@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F957F4A.6090808-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Mon, Apr 23, 2012 at 06:11:54PM +0200, Harald Hoyer wrote:

[..]
> oh.. multipath detection is not yet implemented for host-only... everything else
> should work, though

iscsi does not work either. Just gave it a try and iscsi does not show up
in list of included modules.

Thanks
Vivek
