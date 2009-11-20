From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] switch_root: a better approach to subroots
Date: Fri, 20 Nov 2009 08:05:16 -0600
Message-ID: <1258725916.6283.83.camel@studio>
References: <20091118153312.16E989D404F@zog.reactivated.net>
	 <20091118184706.GB23977@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:content-transfer-encoding:date
         :message-id:mime-version:x-mailer;
        bh=MBlKdymkRQ/chZb4svRkpvYzqMcXyTR9gC+qFXz2kJE=;
        b=wl7uirLn1IkVJRxFs5ucXYCXJOy9TEWJ8dkS7F2SI/qjbft3kUfHDG+kO9Kxyz1U3C
         obZUI/u/UxP7pBB9eZ9cFdFs7TAter6kU5maE0J1KLk5pYPjxlv1zXcNW7S/XJfCLzfu
         HAtRppocIdBELoB2UpKJG02liUOHBewX3SjTw=
In-Reply-To: <20091118184706.GB23977-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, util-linux-ng-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, 2009-11-18 at 19:47 +0100, Karel Zak wrote:
> I think dracut guys should be in CC. Any objection against this change? 
>  
> On Wed, Nov 18, 2009 at 03:33:12PM +0000, Daniel Drake wrote:
> > This reverts commit a692a8745941a192528c5e2a05de97155ba586f9.
> > Booting into a system this way just leads to problems because
> > you cannot remount the root read-only at shutdown (leading to unclean
> > shutdowns).
> > 
> > Miklos Szeredi pointed out a trick to turn any directory into a
> > mount point which avoids this problem. Therefore we can simplify
> > switch_root again and simply document that its users should set
> > up the root as a mount point beforehand.
> > ---
> >  sys-utils/switch_root.8 |   13 +++++++
> >  sys-utils/switch_root.c |   81 +++--------------------------------------------
> >  2 files changed, 18 insertions(+), 76 deletions(-)
> > 
> > diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
> > index 4fdc8e9..b6712ec 100644
> > --- a/sys-utils/switch_root.8
> > +++ b/sys-utils/switch_root.8
> > @@ -32,6 +32,19 @@ show version number and exit
> >  .B switch_root
> >  returns 0 on success and 1 on failure.
> >  
> > +.SH NOTES
> > +switch_root will fail to function if
> > +.B newroot
> > +is not the root of a mount. If you want to switch root into a directory that
> > +does not meet this requirement then you can first use a bind-mounting trick to
> > +turn any directory into a mount point:
> > +.sp
> > +.nf
> > +.RS
> > +mount --bind $DIR $DIR
> 
>  Cannot we add this functionality directly to the switch_root command?
>  I mean call:
> 
>     mount --bind /newroot/subroot /newroot/subroot 
>     mount --move /newroot/subroot /
> 
>  Now we have:
> 
>     mount --move newroot /
>     chroot /newroot/subroot

Sounds like a good idea, even if it is not a common case.  I am fine
with it.

> 
>     Karel
> 
