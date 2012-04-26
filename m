From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: What are the semantics of --mount option
Date: Thu, 26 Apr 2012 12:01:19 +0200
Message-ID: <4F991CEF.3020307@redhat.com>
References: <20120425215006.GA19485@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120425215006.GA19485-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 25.04.2012 23:50, schrieb Vivek Goyal:
> Hi Harald,
> 
> What are the semantics of --mount option. If I call dracut with --mount
> option, can I expect that resulting initramfs will mount that
> filesystem (including network file system) by the time  pre-pivot hook of
> a module is called?

yes, but network setup has to be crafted on the kernel cmdline or in a
/etc/cmdline.d/*.conf
