From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Mon, 20 Feb 2012 19:23:44 +0100
Message-ID: <4F428FB0.3000200@polito.it>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it> <1329312229-11856-2-git-send-email-roberto.sassu@polito.it> <20120220171229.GB26356@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RKcWw1pHeSD8l3ILpFae1Io+n5rUdd6E0HrIvkouWOE=;
        b=vg/MVXd2BrbCvvpyZmT+YdalwJVM2qwvedP5S3JuX2pjPuIYfHToPmRvH0Sd2DEjIU
         r6WhVpmzgwj1cPcxLIKUrrdkAEGo0eTufCmQLDCaG9hB8tOIetosspSEdG0aAP8rGZRb
         droXOorSHHigB8shwuIKqnf/VnA2oVtZqMDko=
In-Reply-To: <20120220171229.GB26356@tango.0pointer.de>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart@poettering.net>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On 02/20/2012 06:12 PM, Lennart Poettering wrote:
> On Wed, 15.02.12 14:23, Roberto Sassu (roberto.sassu@polito.it) wrote:
>
>> The new function ima_setup() loads an IMA custom policy from a file in the
>> default location '/etc/sysconfig/ima-policy', if present, and writes it to
>> the path 'ima/policy' in the security filesystem. This function is executed
>> at early stage in order to avoid that some file operations are not measured
>> by IMA and it is placed after the initialization of SELinux because IMA
>> needs the latter (or other security modules) to understand LSM-specific
>> rules.
>
> This must be a configure option. I am pretty sure most embedded people
> don't require this feature.
>
> The kernel side of things is merged upstream I presume? (We generally
> only want to support stuff in our code that is merged upstream itself)
>

Yes. IMA was in the mainline kernel since 2.6.30.


>> +#define IMA_SECFS_DIR SECURITYFS_MNTPOINT "/ima"
>> +#define IMA_SECFS_POLICY IMA_SECFS_DIR "/policy"
>
> Please use proper strings for this. (see my earlier mail)
>

Ok, i will replace the former with the hard-coded pathname.


>> +#define IMA_POLICY_PATH "/etc/sysconfig/ima-policy"
>
> This is a Fedoraism. Please introduce a proper configuration file for this.
>

Ok, i will answer about this in the next your email.


>> +
>> +int ima_setup(void) {
>> +       struct stat st;
>> +       ssize_t policy_size = 0, written = 0;
>> +       char *policy;
>> +       int policyfd = -1, imafd = -1;
>> +       int result = 0;
>> +
>> +#ifndef HAVE_SELINUX
>> +       /* Mount the securityfs filesystem */
>> +       mount_setup_early();
>> +#endif
>> +
>> +       if (stat(IMA_POLICY_PATH,&st) == -1)
>> +               return 0;
>
> We tend to do "<  0" instead of "== -1" checks for syscall
> failures. Might be good to use the same here, but this is not necessary
> for getting this merged.
>

Ok.


>> +
>> +       policyfd = open(IMA_POLICY_PATH, O_RDONLY);
>
> We tend to add O_CLOEXEC to all fds we open, just for being
> paranoid. Please do so here, too, to avoid surprise and avoid exceptions
> when people grep for all open() invocations looking for O_CLOEXEC.
>

No problem, i will do the change.


>> +       if (policyfd<  0) {
>> +               log_error("Failed to open the IMA custom policy file %s (%s), "
>> +                         "ignoring.", IMA_POLICY_PATH, strerror(errno));
>> +               return 0;
>> +       }
>
> Consider using %m instead of %s and strerror(errno).
>
>> +       imafd = open(IMA_SECFS_POLICY, O_WRONLY);
>
> Also O_CLOEXEC please.
>
>> +       if (imafd<  0) {
>> +               log_error("Failed to open the IMA kernel interface %s (%s), "
>> +                         "ignoring.", IMA_SECFS_POLICY, strerror(errno));
>> +               goto out;
>> +       }
>> +
>> +       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
>> +       if (policy == NULL) {
>
> mmap() returns MAP_FAILED (i.e. (void) -1) on failure, not NULL. This
> check needs to be fixed.
>

Ok, i will replace NULL with MAP_FAILED.


>> +               log_error("mmap() failed (%s), freezing", strerror(errno));
>> +               result = -errno;
>> +               goto out;
>> +       }
>> +
>> +       while(written<  policy_size) {
>> +               ssize_t len = write(imafd, policy + written,
>> +                                   policy_size - written);
>> +               if (len<= 0) {
>> +                         log_error("Failed to load the IMA custom policy "
>> +                                   "file %s (%s), ignoring.", IMA_POLICY_PATH,
>> +                                   strerror(errno));
>> +                         goto out_mmap;
>> +               }
>> +               written += len;
>> +       }
>
> It might make sense to use loop_write() here instead, which does more or
> less this loop, and is defined in util.c anyway.
>

I briefly looked at the code and i'm not sure to use it, because i want
to add some extra information in the output message (for example the
line number of the rule in the policy file that was rejected by IMA).

Thanks

Roberto Sassu


> Otherwise looks good.
>
> Lennart
>

