From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: rdshell and rdbreak
Date: Thu, 29 Sep 2011 10:24:28 +0200
Message-ID: <4E842B3C.4080707@redhat.com>
References: <4E8413A6.2090804@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E8413A6.2090804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/29/2011 08:43 AM, Dave Young wrote:
> Hi,
>
> For kernel developers sometimes boot-test need a minimal initrd, so just
> drop into a shell is a nice feature.
>
> The first impression of param 'rdshell' to me is it will drop me into a
> shell, but It doesn't. It drop into shell only when initramfs fails.
>
> The rdbreak is more near what I want, but it still fails when no root
> args set in cmdline.
>
> IMO initrd can provide such options at least: dropping into shell
> without mount rootfs, user can mount by himself or do other things.
>
> Thus, if it make sense how about add a:
> rdbreak=force
>
> OTOH, rdshell can be merged into rdbreak as:
> rdbreak=fail
>
> Any comments about this?

what about "rdshell rdbreak=cmdline" or
in new syntax "rd.shell=1 rd.break=cmdline" ??
