From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading
 IMA custom policies
Date: Mon, 5 Mar 2012 15:39:50 +0100
Message-ID: <20120305143950.GV10929@tango.0pointer.de>
References: <1329922381-13451-1-git-send-email-roberto.sassu@polito.it>
 <1329922381-13451-2-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329922381-13451-2-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Wed, 22.02.12 15:52, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

Heya,

> +       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
> +       if (policy == MAP_FAILED) {
> +               log_error("mmap() failed (%m), freezing");
> +               result = -errno;
> +               goto out;
> +       }
> +
> +       while(written < policy_size) {
> +               ssize_t len = write(imafd, policy + written,
> +                                   policy_size - written);
> +               if (len <= 0) {
> +                         if (errno == EINVAL)
> +                                   log_error("Invalid line #%d in the IMA custom policy file %s",
> +                                             policy_line_number, IMA_POLICY_PATH);
> +
> +                         log_error("Failed to load the IMA custom policy "
> +                                   "file %s (%m), ignoring.", IMA_POLICY_PATH);
> +                         goto out_mmap;
> +               }
> +               written += len;
> +               policy_line_number++;

I don't understand the counting here of policy_line_number? You attempt
to write the whole policy at once, no? How does this counting of line
numbers work here then? Or does the write() call on the kernel file
actually only accept one line at a time? If that's the case is it really
a good idea to rely on that behaviour? Knowing how these things go
eventually things might get optimized to read more than one line at once
and then the counting here will be off. Maybe it makes sense to drop the
counting entirely here?

(Something else thing that gets me thinking: by mmap()ing the source
file you imply that the policy can never grow beyond 2G or so. I presume
that's not a problem, right?)

Otherwise looks good.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
