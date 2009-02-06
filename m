From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 11:56:02 -0500
Message-ID: <20090206165601.GF11144@nostromo.devel.redhat.com>
References: <20090206164019.GD552@redhat.com> <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA-IGOiFh9zz4yvNW/NfzhIbrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

Danecki, Jacek (jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said: 
> > Is there a real need for mdmon to start prior to being in the real
> > rootfs?
> 
> mdmon is needed to change raid array to RW mode, so as long as rootfs is mounted RO, mdmon can be started in real rootfs.

So, for one particular specific type of block device, you need
a daemon to switch it writable. Every other type of block device
can handle this without separate tooling. I'm not seeing how this
is an improvement.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
