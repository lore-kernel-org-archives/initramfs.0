From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added
  support for loading IMA custom policies
Date: Mon, 20 Feb 2012 18:21:50 +0100
Message-ID: <20120220172149.GF26356@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
 <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
 <4F3BDCAA.7040001@polito.it>
 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it>
 <4F3C8C6F.4010708@gmail.com>
 <4F3D06D1.7000404@polito.it>
 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>
Cc: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Michael Cassaniti <m.cassaniti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Thu, 16.02.12 12:30, Gustavo Sverzut Barbieri (barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org) wrote:

> > Since the policy loading can be implemented in different ways depending
> > on the init system (systemd, upstart, ...), an user must identify the
> > components to be measured for each case. Instead, if the IMA policy is
> > loaded in the main Systemd executable, only this file must be measured
> > by the boot loader.
> 
> Then I wonder: why not make an ima-init binary that:
>   - does ima_setup()
>   - exec systemd || upstart || ...
> 
> this way you only have to audit this very small file and not systemd
> itself, it's very early and so on.

We worked really hard on being able to load the SELinux policy without
any unnecessary (re-)execs. I don't think we should reopen that problem
by loading IMA from a pre-init tool. Also, the management of such a
thing would seriously suck (i.e. you'd probably need something like
update-alternatives, and that sucks), especially since we now already
taught the initrd to spawn /usr/lib/systemd/systemd directly, instead of
/sbin/init.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
