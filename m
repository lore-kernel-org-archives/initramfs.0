From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added
  support for loading IMA custom policies
Date: Mon, 20 Feb 2012 18:18:29 +0100
Message-ID: <20120220171829.GE26356@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
 <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
 <4F3BDCAA.7040001@polito.it>
 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it>
 <4F3C8C6F.4010708@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F3C8C6F.4010708-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Cassaniti <m.cassaniti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Thu, 16.02.12 15:56, Michael Cassaniti (m.cassaniti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) wrote:

> >>>>Also, I certainly have no such things in my system and see no point in
> >>>>calling ima_setup() on it. Or even compiling the source file in such
> >>>>case.
> >>>>
> >>>Ok. I can enclose the code in ima-setup.c within an 'ifdef HAVE_IMA'
> >>>statement, as it happens for SELinux. However an issue is that there is no a specific package for IMA that can be checked to set the HAVE_IMA
> >>>definition to yes. Instead, the code can be enabled for example by
> >>>adding the parameter '--enable_ima' in the configure script.
> >>okay.
> >>
> I'm under the impression this function belongs to a userspace tool.
> If not then I just don't see a good reason that this patch is
> required. I do understand that the IMA policy should be loaded as
> early as possible, but I believe that early userspace scripts should
> be doing that work. If it is a userspace function, then whatever
> makes you happy, other distro's will roll their own.

in systemd, bootup is fully parallelized. I much prefer invoking the IMA
policy at the right time, before we spawn off the first processes,
instead of having to express that with dependencies towards all units.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
