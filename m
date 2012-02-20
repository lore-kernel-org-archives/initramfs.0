From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 1/2] systemd: mount the securityfs
 filesystem at early stage
Date: Mon, 20 Feb 2012 18:04:37 +0100
Message-ID: <20120220170436.GA26356@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329312229-11856-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Wed, 15.02.12 14:23, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

> The mount of the securityfs filesystem is now performed in the main systemd
> executable as it is used by IMA to provide the interface for loading custom
> policies. The unit file 'units/sys-kernel-security.mount' has been removed
> because it is not longer necessary.
>  
> +#define SECURITYFS_MNTPOINT "/sys/kernel/security"
> +

Just use the proper path name here. Not sure why we would want a macro
for this, as things are simpler with literal strings for this, the path
is unlikely to change and we generaly don't do this for any of the other
paths.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
