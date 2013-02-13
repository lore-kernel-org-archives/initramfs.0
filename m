From: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: MD Raid1 driver missing from hostonly initramfs
Date: Wed, 13 Feb 2013 15:17:52 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1302131513310.11804@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301251127050.31163@jlaw-desktop.mno.stratus.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1301251127050.31163-ceYW5R1vr2hcrvxNGtJwk767FWEIOpWeVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Fri, 25 Jan 2013, Joe Lawrence wrote:

> Hi Harald,
> 
> Another bug report... when I run dracut in host-only mode on an MD raid1
> install, the raid1.ko driver is not included in the initramfs.

[ ... snip ... ]

In case anyone else hits this, turns out this was fallout from: 

Wed Jan 23 commit c8d685c9d3860e49f39a9c85ffebbb4c4fec341f 
dracut-functions.sh: cope with optional field #7 in mountinfo

that was fixed in commit:

Tue Feb 5 commit 19bab59c48ba6edbdf9d6d9f339baef250bdd4a6 
dracut.sh: reverting return value change


Regards,

-- Joe
