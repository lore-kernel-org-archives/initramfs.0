From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 2/2] ssh-client: add urandom seeding
Date: Thu, 11 Oct 2012 16:25:17 +0800
Message-ID: <5076826D.2020201@redhat.com>
References: <20121011080757.285843621@redhat.com> <20121011080918.972371593@redhat.com> <50768041.8000803@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50768041.8000803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 10/11/2012 04:16 PM, Harald Hoyer wrote:

> Hmm, wouldn't that mean, that the generator is seeded with the _same_ seed on
> every reboot?
> How is this different from booting with no seed at all?


This is intend to resolve the no-sufficient-entropy issue during ssh
connection. But, yes it's same across reboot if the initrd is not
regenerated.

In old kdump code we originally copy bytes from /dev/mem, but that is
not good because /dev/mem is access denied, also it's not so random as well.

> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
