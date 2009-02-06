From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 11:02:08 -0700
Message-ID: <e9c3a7c20902061002q6d1ee17cm9029d5b3369354e8@mail.gmail.com>
References: <20090205224808.18610.14957.stgit@dwillia2-linux.ch.intel.com>
	 <20090205224920.18610.63979.stgit@dwillia2-linux.ch.intel.com>
	 <20090206164019.GD552@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=ufREcsPxNU1PrKEWH0vTByCdoxfbnEKA1++CnwTC2IY=;
        b=FESMDmThIxcDiUiixfrZHvbIpXzSajvPXBbIgAAcla7jDWDXSdDniiHW8aYle4Rkf1
         6BM48BRaVvk5Mguih66Aj18PBMz8VpDVQVNef3UXz6e9otkQwj/XyE45d3ed+qReXaHM
         m+IWp5NMkM4NWgCh0FxabdJuuubd8RG6FxUtU=
In-Reply-To: <20090206164019.GD552-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neilb-l3A5Bk7waGM@public.gmane.org, jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>

On Fri, Feb 6, 2009 at 9:40 AM, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> RAID arrays should be getting started by udev rules, not by explicit
> calls to mdadm in /init.  Yes, this means having proper integration with
> udev for your kernel pieces.  But this ends up helping everything as it
> will also let us lose the multiple redundant calls to things like mdadm
> (and lvm, etc) throughout the boot process which should just be
> occurring as devices show up.

The trick is determining when a device has not shown up yet versus it
will never show up... to prevent the array being marked degraded
prematurely.  Is there some mechanism for udev to broadcast "if you
were waiting for more devices to show up don't hold your breath"?
I.e. at the point where a call to "udevadm settle" would reasonably be
expected to not find any pending events?

I am thinking something along the lines of:
<udev: add disk>
mdadm --incremental --no-degraded $dev
<udev: add disk>
mdadm --incremental --no-degraded $dev
<udev: probably no more devices>
mdadm --incremental $last_dev

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
