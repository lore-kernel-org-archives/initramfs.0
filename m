From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading
 IMA  custom policies
Date: Mon, 20 Feb 2012 18:13:56 +0100
Message-ID: <20120220171356.GC26356@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
 <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
 <4F3BDCAA.7040001@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F3BDCAA.7040001-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Wed, 15.02.12 17:26, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

> 
> On 02/15/2012 03:30 PM, Gustavo Sverzut Barbieri wrote:
> >On Wed, Feb 15, 2012 at 11:23 AM, Roberto Sassu<roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>  wrote:
> >>The new function ima_setup() loads an IMA custom policy from a file in the
> >>default location '/etc/sysconfig/ima-policy', if present, and writes it to
> >
> >isn't /etc/sysconfig too specific to Fedora?
> >
> 
> Hi Gustavo
> 
> probably yes. I see the code in 'src/locale-setup.c' where the
> the configuration directory depends on the target distribution.
> I can implement something like that in my patch.

We will sooner or later drop the per-distro ifdeffery. Please don't even
start it for new code. Given that IMA is still new, please make sure to
adopt configuration fails that are the same across all distributions.

> >Also, I certainly have no such things in my system and see no point in
> >calling ima_setup() on it. Or even compiling the source file in such
> >case.
> >
> 
> Ok. I can enclose the code in ima-setup.c within an 'ifdef HAVE_IMA'
> statement, as it happens for SELinux. However an issue is that there
> is no a specific package for IMA that can be checked to set the
> HAVE_IMA
> definition to yes. Instead, the code can be enabled for example by
> adding the parameter '--enable_ima' in the configure script.

Sounds good.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
