From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [RFC][PATCH 8/9] ima: include tmpfs in ima_appraise_tcb policy
Date: Thu, 8 Jan 2015 08:53:46 -0500
Message-ID: <CA+5PVA7QiaLpiH+7oWQ5Uu8Z30mPczou89_9ga1CnW6c+_cQWQ@mail.gmail.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1420663980-20842-9-git-send-email-zohar@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GmE7mdgmcBxHwU1f/eAJ7L2snzzfgJIG4SJMUtjuF0I=;
        b=lMwzlSgykX9vVtUrPeEiza6uPAl+jSpXi7lQCOkIB/GEBfLOMkZUtRUG3jK3tbi0J4
         lHh1PqbdqVx5eYpVGOXSXoQLK1NMlWsKbq0Udg60kWIw83vcvmDxHSZfZJn+lugWQ2Ut
         xw2wARJ6LG96wF3nyFFzj9dE1l3Rl4aN/KIj/owOCYievXqz4yun2+K/G2yKis5jKI+3
         Cmtc12pjcZP4VSwbClDgEBcz68tPEdVJfJ5BQT010yLq6zbYnyfWeIQ+SQj5nWCKI3Ht
         XdZtul9HJIEuBT5uKS26OnX9HbPz+6dxFOr3p97lmIEnpiCG7SoKnRaiZmg6BYcv8o/K
         vocw==
In-Reply-To: <1420663980-20842-9-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: initramfs <initramfs@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Jan 7, 2015 at 3:52 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Now that the rootfs includes extended attributes, don't
> automatically exclude tmpfs file systems from being appraised.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/evm/evm_main.c   | 1 +
>  security/integrity/ima/ima_policy.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 9c71af7..e942e63 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/crypto.h>
>  #include <linux/audit.h>
> +#include <linux/magic.h>
>  #include <linux/xattr.h>
>  #include <linux/integrity.h>
>  #include <linux/evm.h>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index d1eefb9..7267eac 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -93,7 +93,9 @@ static struct ima_rule_entry default_appraise_rules[] = {
>         {.action = DONT_APPRAISE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
>         {.action = DONT_APPRAISE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
>         {.action = DONT_APPRAISE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
> +#ifndef CONFIG_IMA_LOAD_X509
>         {.action = DONT_APPRAISE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
> +#endif

The commit log makes it sound like tmpfs should be appraised
unconditionally, but you only have it being appraised if IMA_LOAD_X509
is set.  Which is correct (and why isn't it based on whether
CONFIG_IMA_APPRAISE is set)?

Also, what happens if someone creates an initramfs that doesn't
include xattrs and has this option set?

Slightly confusing.

josh
