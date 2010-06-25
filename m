From: Dave Stone <fsck1234-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: I added one dracut module into initial ramdisk, but it is not =?utf-8?b?CWNhbGxlZA==?=
Date: Fri, 25 Jun 2010 19:27:31 +0000 (UTC)
Message-ID: <loom.20100625T212536-159@post.gmane.org>
References: <AANLkTilYnPkMWI5kff6veRazkdLuluOmIId14JMu3eWi@mail.gmail.com> <4C1A1DC2.5050401@redhat.com> <AANLkTimI0Ej-NueQz5KcnM3WSRb5H2rZ0ng_SrqgwWfD@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Min Jun,Xi <xi.minjun@...> writes:

> 
> I made the changes you mentioned, and have re-generated the initrd,
> and rebooted the node;
> 
> I also run "dmesg|grep xcat", but I couldn't get anything.
> 

Hi Min,

I'm new to dracut as well.  But here is a couple of things that might help you.
1. Make sure "check" and "install" and other scripts are executable
2. Dracut has -v --debug output options which can be redirected to a file.  
Then you can look for problems that might have prevented dracut to include 
your module.

Regards,

-Dave 

Pruned....
