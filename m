From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Fri, 6 Mar 2009 15:39:21 -0500
Message-ID: <20090306203921.GA28154@nostromo.devel.redhat.com>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1236361391.6517.0.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
> > > http://git.surfsite.org/dracut.git
> > > git://surfsite.org/pub/git/dracut.git
> > 
> > Wasn't the entire point to make the initramfs generic?
> 
> No, to make the initramfs generator generic. A subtle but important
> distinction.

Nope. The plan was (quoting earlier mails to the list, from the
creators...):

...
[I]nstead of scripts hard-coded to do various things, we depend on
udev to create device nodes for us and then when we have the
rootfs's device node, we mount and carry on
...
There's another reason this is really useful.
If something goes wrong, remotely debugging a users initrd right is
a lot easier if you know what it looks like.  Right now, in Fedora for eg,
where we generate an initrd for each users system at runtime, we need
to get a copy of the generated initrd, and pull it apart just to find
out what modules ended up in there, what didn't, and then somehow
try to work backwards to try and figure out how the generator got into
that state.  After doing this for five years, let me tell you it's
_really_ _really_ painful.
...

And now we've got large patchsets that:
- make the initramfs non-generic (in fact, machine-specific)
- handle various device types through shell snippets, not udev
  (raid, crypt, etc.)
- farm everything out to random modules, so no initramfs is alike

I think something's been lost here.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
