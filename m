From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 12:38:14 -0500
Message-ID: <20090206173814.GA3541@nostromo.devel.redhat.com>
References: <20090206164019.GD552@redhat.com> <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com> <20090206165601.GF11144@nostromo.devel.redhat.com> <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e9c3a7c20902060927j2b900940kd851573469110135-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said: 
> It is not just setting writable, mdmon is also there to clear the bit
> when writes have quiesced.

Let me just see if I understand this infrastructure correctly.

- device is set writable
- kernel tells userspace
- userspace frobs bit in superblock to say 'I want to be dirty!'
- userspace tells kernel
- kernel writes bit to disk
... stuff happens ...
- userspace tells kernel to unmount, or remount R/O
- kernel tells userspace "hey, i unmounted this"
(userspace freaks out because the filesystem the daemon is running on
 just went away)
- userspace frobs bit in superblock to say 'This array is CLEAN!'
- userspace tells kernel
- kernel writes bit to disk

Is that really how it's supposed to work?

So, why isn't the ext* journal or filesystem unclean flag
handled via a userspace file monitoring daemon, then?

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
