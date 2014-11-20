From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: SUSE patches which should show up mainline
Date: Thu, 20 Nov 2014 15:56:35 +0100
Message-ID: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

in the past weeks/months SUSE somewhat diverged from mainline development
due to SLE12 work.

This was/is not intended and here are general fixes/enhancements which should
show up mainline.

I merged quite some (on top fixes/enhancements) together to avoid to submit
half baken or broken patches.
I also put iscsi, multipath (forgot fcoe ones, but that should not matter
right now) patches together for easier review.

S390 specific patches were left out. There have been some specialities and
dracut would be the wrong place to start consolidating things.

Be carefule with patches:
[PATCH 08/33] 90multipath: Install libgcc_s library
[PATCH 12/33] 95iscsi: Install libgcc_s library
these might already be fixed, compare with mail:
Multithreaded programs crashing due to libgcc_s missing
from 06/06/14 and 07/22/14

It may make sense to first do a version jump to 041 before merging these?

Would be nice to see as much of these pushed already as possible.
I am willing to re-submit remaining patches which are questionable or need
re-work after discussing.

Thanks a lot in advance,

       Thomas
