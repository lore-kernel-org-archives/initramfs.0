From: Lennart Poettering <mzerqung-uLTowLwuiw4b1SvskN2V4Q@public.gmane.org>
Subject: Re: [systemd-devel] dracut: ordering of modules
Date: Fri, 10 Feb 2012 19:14:14 +0100
Message-ID: <20120210181413.GA13111@tango.0pointer.de>
References: <1328886121.2472.19.camel@falcor>
 <4F353840.8050505@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F353840.8050505-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, selinux-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Fri, 10.02.12 16:31, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

> 
> Hi Mimi
> 
> i'm CCing the systemd and Fedora SELinux mailing lists.
> 
> Unfortunately, the SELinux policy initialization (at least
> in Fedora 16) has been moved to systemd, so, now, loading an
> IMA policy cannot be done in the initial ramdisk.
> 
> Further, the SELinux policy loading code is not in a unit file
> but embedded in the main binary, which means that the new code for
> loading IMA policies must be added just after that point.
> 
> I already wrote a patch for this. I need some time to test it
> and will post in the systemd mailing list at the beginning of
> the next week.

Hmm, what is this about? You need a place to load additional security
policies into the kernel at early boot? For SELinux that indeed takes
place from within PID 1 now in systemd. I'd expect that other security
technologies like AppArmor should work the same.

If you want to hack on this basing your work on selinux-setup.c in the
systemd tree should be fairly easy.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
