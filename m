From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: live rootfs from squashfs and read write ability
Date: Thu, 29 May 2014 14:39:26 +0800
Message-ID: <20140529063926.GJ2068@darkstar.nay.redhat.com>
References: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
 <20140522095925.GG1859@darkstar.nay.redhat.com>
 <CACaajQvz1e=nYW1C49ExcWAAZHCy9e=tZMMJbtevFAA=37t3gQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACaajQvz1e=nYW1C49ExcWAAZHCy9e=tZMMJbtevFAA=37t3gQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/23/14 at 01:04am, Vasiliy Tolstov wrote:
> 2014-05-22 13:59 GMT+04:00 Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> >
> > I don't think there's easy solution for read-write mount since it need stacked fs like
> > unionfs. But maybe you can try mount some folder as tmpfs such as /tmp, /var etc.
> > and only write to the specific folders.
> >
> > I imagine a simpe implement for unionfs specific for initramfs use..
> >
> > Thanks
> 
> 
> I'm try to implement overlayfs mount (backend squashfs, frontend tmpfs).
> Can you check https://github.com/haraldh/dracut/pull/20.patch or
> https://github.com/haraldh/dracut/pull/20 and give to me some
> suggestion, how can i best do this?

Sorry I'm not familar with livenet I can not comment anything now.
BTW, overlayfs is not in mainline kernel yet.

What I would like to see is something like squashinitramfs, a squashed initrd can be
automatilly recognized and union mounted while kernel booting without any userspace
hacks. But seems nobody is doing like this.

Thanks
Dave
