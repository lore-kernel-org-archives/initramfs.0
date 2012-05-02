From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Does netroot=isci: option work with latest dracut
Date: Wed, 02 May 2012 11:12:48 +0200
Message-ID: <4FA0FA90.1010702@redhat.com>
References: <20120501164704.GA18202@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120501164704.GA18202-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 01.05.2012 18:47, schrieb Vivek Goyal:
> Hi,
> 
> On F17, I am trying kdump to an iscsi target. And I am passing a
> netroot=iscsi:..... cmdline to dracut. But that does not seem to work.
> 
> Some debugging showed that we do parse the netroot= arguemnt in
> parse-iscsiroot.sh but after that nothing happens. Nobody tries to
> bring up the iscsi luns.
> 
> I see some code in iscsiroot.sh to call iscsistart to bring up iscsi
> luns but that code does not seem to be hooked up. I could not figure
> out who calls /sbin/iscsiroot.
> 
> So I am wondering if I am doing something wrong or there is some
> disconnect in my understanding of how netroot= options works.
> 
> Thanks
> Vivek

did you specify "ip=..." ?
