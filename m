From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: multipath device issue
Date: Thu, 02 Aug 2012 10:07:14 +0200
Message-ID: <501A3532.7010907@redhat.com>
References: <501A0B87.9070506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501A0B87.9070506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 02.08.2012 07:09, schrieb Dave Young:
> Hi,
> 
> The multipath device node was not created during testing kdump on
> multipath target. dracut drop into emergency shell,  I checked that
> 'multipathd -B' was running in background. Any idea?
> 
> Attached the full log of debug info.
> 

hmm.. I hope, this did not introduce a regression:
http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=c0cae7f702b5ccf27a80913642aec8bf15fe710e
