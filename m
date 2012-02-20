From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading
 IMA custom policies
Date: Mon, 20 Feb 2012 18:12:29 +0100
Message-ID: <20120220171229.GB26356@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329312229-11856-2-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Wed, 15.02.12 14:23, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

> The new function ima_setup() loads an IMA custom policy from a file in the
> default location '/etc/sysconfig/ima-policy', if present, and writes it to
> the path 'ima/policy' in the security filesystem. This function is executed
> at early stage in order to avoid that some file operations are not measured
> by IMA and it is placed after the initialization of SELinux because IMA
> needs the latter (or other security modules) to understand LSM-specific
> rules.

This must be a configure option. I am pretty sure most embedded people
don't require this feature.

The kernel side of things is merged upstream I presume? (We generally
only want to support stuff in our code that is merged upstream itself)

> +#define IMA_SECFS_DIR SECURITYFS_MNTPOINT "/ima"
> +#define IMA_SECFS_POLICY IMA_SECFS_DIR "/policy"

Please use proper strings for this. (see my earlier mail)

> +#define IMA_POLICY_PATH "/etc/sysconfig/ima-policy"

This is a Fedoraism. Please introduce a proper configuration file for this.

> +
> +int ima_setup(void) {
> +       struct stat st;
> +       ssize_t policy_size = 0, written = 0;
> +       char *policy;
> +       int policyfd = -1, imafd = -1;
> +       int result = 0;
> +
> +#ifndef HAVE_SELINUX
> +       /* Mount the securityfs filesystem */
> +       mount_setup_early();
> +#endif
> +
> +       if (stat(IMA_POLICY_PATH, &st) == -1)
> +               return 0;

We tend to do "< 0" instead of "== -1" checks for syscall
failures. Might be good to use the same here, but this is not necessary
for getting this merged.

> +
> +       policyfd = open(IMA_POLICY_PATH, O_RDONLY);

We tend to add O_CLOEXEC to all fds we open, just for being
paranoid. Please do so here, too, to avoid surprise and avoid exceptions
when people grep for all open() invocations looking for O_CLOEXEC.

> +       if (policyfd < 0) {
> +               log_error("Failed to open the IMA custom policy file %s (%s), "
> +                         "ignoring.", IMA_POLICY_PATH, strerror(errno));
> +               return 0;
> +       }

Consider using %m instead of %s and strerror(errno).

> +       imafd = open(IMA_SECFS_POLICY, O_WRONLY);

Also O_CLOEXEC please.

> +       if (imafd < 0) {
> +               log_error("Failed to open the IMA kernel interface %s (%s), "
> +                         "ignoring.", IMA_SECFS_POLICY, strerror(errno));
> +               goto out;
> +       }
> +
> +       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
> +       if (policy == NULL) {

mmap() returns MAP_FAILED (i.e. (void) -1) on failure, not NULL. This
check needs to be fixed.

> +               log_error("mmap() failed (%s), freezing", strerror(errno));
> +               result = -errno;
> +               goto out;
> +       }
> +
> +       while(written < policy_size) {
> +               ssize_t len = write(imafd, policy + written,
> +                                   policy_size - written);
> +               if (len <= 0) {
> +                         log_error("Failed to load the IMA custom policy "
> +                                   "file %s (%s), ignoring.", IMA_POLICY_PATH,
> +                                   strerror(errno));
> +                         goto out_mmap;
> +               }
> +               written += len;
> +       }

It might make sense to use loop_write() here instead, which does more or
less this loop, and is defined in util.c anyway.

Otherwise looks good.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
