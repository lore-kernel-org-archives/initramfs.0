From: Tree Davies <tree-T6ihzTOBfThe2x7YuqFggA@public.gmane.org>
Subject: FATAL: Don't know how to handle 'root=live
Date: Sun, 29 Aug 2021 11:17:02 -0700
Message-ID: <950d6672-888e-ef1c-0df8-c803944c231f@darkphysics.net>
References: <28baa9ad-072c-d086-d7ff-e00fb4ea2e65@darkphysics.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=subject
        :references:to:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=l0Tvfqe4QHfY
        Vbfo+OZzZE+93QWhM8/P6N6uc7LI7sw=; b=F8efpdhLZRYe7qwC6+WJ/j8izCKt
        /cIQZtxebOPDEOPcfI/RwjFgrSaX57JyTQA7Ltvrj8ho97SsGi+nzTQKUsfSYTme
        NWJx0YkXQPJ1wNe3Y8x+p624UTM+9emQ2o9iQA2Yh9sVh30VbSFtMTkLfDtA8dlH
        y5IAAQZLvnnx0ws=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=subject:references:to:from:message-id:date:mime-version:in-reply-to:content-type:content-transfer-encoding; s=2019-09.pbsmtp; bh=l0Tvfqe4QHfYVbfo+OZzZE+93QWhM8/P6N6uc7LI7sw=; b=LknFvuYXsajYvFrlIMQYfjMhmI4s9yKac2ehWSo29c9QvETh68qO51wO0CYoLCMRFxj3QHVBp9A75N9C4If9mgzDWD8Oa8r22O2A0bz1iAEfFPRxlZgAUOlxDtFPvXaxcqWKIKES8liDGbRj+lhC7OjbEpfwyTf8Gq+VqDAW33I=
In-Reply-To: <28baa9ad-072c-d086-d7ff-e00fb4ea2e65-T6ihzTOBfThe2x7YuqFggA@public.gmane.org>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Everyone,

I am attempting to boot from USB using syslinux/isolinux with a
squashfs image as my root filesystem.

My kernel command line like looks like:
linux /LiveOS/vmlinuz.x86_64 root=live:CDLABEL=Physix-Project rd.live.image
APPEND initrd=/LiveOS/initramfs-img.x86_64

At boot, the system halts soon after the following message.
dracut: FATAL: Don't know how to handle 'root=live:Physix-Project

I got the impression from dracut docs that I needed dmsquash-live and 
livenet module included in the initramfs, but when I define them in my 
/etc/dracut.conf and run make install on the kernel tree I get the 
following messages:
`dracut: dracut module 'livenet' depends on 'dmsquash-live', which can't 
be installed
dracut: dracut module 'dmsquash-live' cannot be found or installed.`

Question 1: Will including these 2 modules solve the "FATAL: Don't know 
how to handle 'root=...." issue?

Question 2: If so, how do I get these modules installed (on 
Debian/Fedora) so I can build the initramfs?

best regards,
Tree

