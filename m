From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Thoughts on mounting the rootfs from a udev rule
Date: Thu, 19 Mar 2009 16:06:25 -0500
Message-ID: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=dNmCGSpEbYl4AUh97YqlzArIwR/QnXnuq9R5/6+kinc=;
        b=Du+hzIp9zDF+/+jShxkNGzzP+UPWoxL5bn96is4slOcKMxcNA8WUMQZtWsNKTBMqZ6
         p3R7z+6GBU/Ts13kGQbZzamWcrlVtMOJJfCm8/6PhyzOule2J/IpJenUcZKBqMVN6l80
         QftgSkMysuQvwhN0/UjVJTLK7S/XycgTdQLIE=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

It seems that there are two major use cases that make mounting the root
file system directly from a udev rule an inadvisable design decision:

The first is when your root filesystem does not reside on a block
device, as in the nfsroot case.  In this case, there is no backing
device for the filesystem for udev to detect, so we would still need a
non-udev method of mounting the root filesystem in order to handle any
case where there is no backing device for the root filesystem.

The second is when we are asked to resume from hibernate.  In this case,
we must not attempt to mount the root filesystem (or any other
filesystem, for that matter) until we have either attempted to resume
(and failed) or we have determined that resuming is impossible.  Udev
does not make any guarantees about the order in which devices are
discovered, which leads to all sorts of interesting potential failure
modes when you have either or both of resume handling and rootfs
handling in a udev rule.

Thoughts?

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
