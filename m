From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading
 IMA  custom policies
Date: Mon, 20 Feb 2012 19:52:42 +0100
Message-ID: <20120220185236.GB360@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
 <20120220171229.GB26356@tango.0pointer.de>
 <4F428FB0.3000200@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F428FB0.3000200-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Mon, 20.02.12 19:23, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

> >>+               log_error("mmap() failed (%s), freezing", strerror(errno));
> >>+               result = -errno;
> >>+               goto out;
> >>+       }
> >>+
> >>+       while(written<  policy_size) {
> >>+               ssize_t len = write(imafd, policy + written,
> >>+                                   policy_size - written);
> >>+               if (len<= 0) {
> >>+                         log_error("Failed to load the IMA custom policy "
> >>+                                   "file %s (%s), ignoring.", IMA_POLICY_PATH,
> >>+                                   strerror(errno));
> >>+                         goto out_mmap;
> >>+               }
> >>+               written += len;
> >>+       }
> >
> >It might make sense to use loop_write() here instead, which does more or
> >less this loop, and is defined in util.c anyway.
> 
> I briefly looked at the code and i'm not sure to use it, because i want
> to add some extra information in the output message (for example the
> line number of the rule in the policy file that was rejected by IMA).

Line number? The policy is text? Your code above doesn't print any line
numbers?

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
