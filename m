From: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut: qestions about mdraid module
Date: Sat, 27 Sep 2014 17:21:42 +0200
Message-ID: <5426D606.6020300@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=vRcK2WyL4ufcfiMSas6lX1RIICO0Nmb+B/fIby4+xsw=;
        b=ALL92BqiDzqQx8+nri1pZEcLlIMNf+mVZxdO2qxXbKyHayvH0bOv11bmKzw21don3j
         ErHcp+IGQ6qKC9Ny8QrbgETzxcZkC4Hjd18L2+wVqfNYatm/3xduqu+0PLiPtGo/UO/M
         WsMZ0P7yK75kfSxIwch8RvSxB95Za82fkT4hWSXQCcC6c9XGteTumxayQGhIChUixtUf
         hF0VEH+eFRG9Vv+8d+8RDEhj0LIuB7/xjg1v6L+c9i0Ev4XdffuP5Nxdc8H3v+MiUv6T
         WaqF2CLR46n/VvznfU6yhPdEXIXIis4Ky9TXcnRFRmyBx3WLRqsuhkxB593dU9tKR61z
         53Zg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I'm looking at the module 'mdraid' of dracut (0.38) and was wondering
the purpose of rd.md.uuid= parameter.

I understand it can be used to selectively activate the array matching
the UUID passed through the parameter but I'm wondering in which cases
it can be useful...

Also I don't really understand why dracut try to do its own mechanism to
achieve that (by providing its own udev rules which are modified at boot
time) whereas mdadm already provide the infrastructure (through
mdadm.conf) in a cleaner way (IMHO).

Another question, hopefully you don't mind: dracut provide an udev set
of rules in a file named 59-persistent-storage-md.rules. I still don't
really see the point since most of the stuff in it seems to already be
done by the rule fileudev-md-raid-arrays.rules, shipped by mdadm (3.3.2).

Ah my last question not related to mdraid: why dracut uses stderr to
print out all its messages: info, debug, error. Stderr is usually used
for error/warning messages only.

Thanks !
