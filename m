From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut
Date: Tue, 26 Oct 2010 13:09:25 +0200
Message-ID: <4CC6B6E5.50402@redhat.com>
References: <4CBDA328.40401@googlemail.com> <4CC17713.4030504@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC17713.4030504-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/22/2010 01:35 PM, Mr Dash Four wrote:
> Is it possible to build dracut for system/architecture which is different from
> the host on which dracut is run?
>
> I have been looking through the various functions dracut provides (inst_binary
> in particular) and it seems that dracut picks-up dependencies/libraries/kernel
> modules and files on the host machine when building the initrd image, which to
> me indicates that the resulting initrd image is tied to the current
> kernel/architecture on which the host is run and cross-building won't be possible.

kernel/architecture, yes

Cross building for other architectures is difficult, because all the tools like 
"ldd", "modprobe", etc. would have to be cross tools.

Kernel could be solved by specifying the kernel version and having that version 
installed.
