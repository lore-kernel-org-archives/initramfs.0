From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [RESEND] Early cpio decoder and ACPI table override via initrd making use of it
Date: Tue, 25 Sep 2012 16:55:55 +0200
Message-ID: <1348584961-1476-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org

Hi,

this is the updated version with following changes as suggested
by Len and Yinghai:
  - spelling corrections
  - macro hiding in header files
  - splitting up patches

There shouldn't be any functional changes since the last version.

I guess the only part missing is a more explicit ack from Len than
"this is not a nak"?
Then this can go into linux-next through a X86 branch pushed by
hpa (as there are quite some x86 specific parts)?

The patches are on top of latest Linus tree.

Thanks,

    Thomas

