From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Mon, 25 May 2009 22:58:02 -0400
Message-ID: <1243306682.3584.42.camel@obelisk.thedillows.org>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
	 <1243305738.3584.40.camel@obelisk.thedillows.org>
	 <20090526024454.GA10049@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090526024454.GA10049-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-05-25 at 22:44 -0400, Jeremy Katz wrote:
> On Monday, May 25 2009, David Dillow said:
> > dash gets upset when it cannot open /dev/tty, and we lose stderr. Even
> > if we make /dev/tty once we're in the initramfs, it will still be too
> > late for the inital dash shell running the init script. So, make a small
> > set of nodes in the dracut script while building the directory structure
> > of the initramfs.
> 
> Creating the nodes in the dracut script means that you can't create the
> initramfs as non-root, though.  :(

Bummer, that. And while it makes the initial dash able to give us
stderr, it doesn't fix the emergency shell. Of course, I noticed this
after hitting send... so bad patch all around. :(

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
