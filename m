From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: "kdumpbase" dracut module
Date: Mon, 21 Mar 2016 14:26:55 +0800
Message-ID: <20160321062655.GA9896@dhcp-128-65.nay.redhat.com>
References: <CACeEjSL0jrqF9WtX3mZrO0036pGc4O4aPg+=JPMOB7QH47DLWA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACeEjSL0jrqF9WtX3mZrO0036pGc4O4aPg+=JPMOB7QH47DLWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ronit Halder <ronit.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernelnewbies <kernelnewbies-7JyXY6prKcjpASu1u0TL5ti2O/JbrIOy@public.gmane.org>

On 03/19/16 at 12:59pm, Ronit Halder wrote:
> I want to know what is the job of "kdumpbase" dracut module.

Suppose you are using Fedora or RHEL, it is a out of tree module for creating
kdump initramfs. Fedora package kexec-tools will install it to dracut module
directory.

Thanks
Dave
