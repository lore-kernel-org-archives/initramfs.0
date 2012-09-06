From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: Override rd.md settings if rd.md.uuid is provided
Date: Thu, 6 Sep 2012 09:57:22 -0400
Message-ID: <20120906135722.GB27209@redhat.com>
References: <20120905212047.GE19749@redhat.com>
 <20120905212434.GA27154@redhat.com>
 <50487777.1050502@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50487777.1050502-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Thu, Sep 06, 2012 at 12:14:15PM +0200, Harald Hoyer wrote:

[..]
> 
> 
> Similar patch comitted upstream

Hi Harald,

I think we need to use && instead of || in upstream committed patch.

+if ! [ -n "$MD_UUID" ] || ! getargbool 1 rd.md -d -n rd_NO_MD; then

Otherwise even if MD_UUID is defined, we check for rd_NO_MD and disable
raid activation. It is not different from behavior without patch.

Thanks
Vivek


