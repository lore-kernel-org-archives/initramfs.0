From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Fri, 06 Mar 2009 17:35:32 -0600
Message-ID: <1236382532.5147.38.camel@sentry-no.fnordovax.org>
References: <49B1439A.7030208@redhat.com>
	 <20090306160822.GD10711@nostromo.devel.redhat.com>
	 <1236361391.6517.0.camel@sentry-no.fnordovax.org>
	 <20090306203921.GA28154@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=R7P2Bs4g8mWdK6vAkIe1rWBUh2s2RG/bztidvUo3toA=;
        b=BrpGqji/gOTX9Uh5ew/+MWOqnEcN5hMvEi7tYpxMYqz3Su06KdN8drtvH8SH0RwmK+
         MLVgfcaGabbb2Vahzo1qn4rVpkuyGikUpUgLmnfGCKFFHX7MO2BJhYz3AYX1pizofU/2
         0TdAW+7HyLhHNgQGdFuBrxOGB7yKMrr7aB/Wk=
In-Reply-To: <20090306203921.GA28154-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-03-06 at 15:39 -0500, Bill Nottingham wrote:
> Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
> > > > http://git.surfsite.org/dracut.git
> > > > git://surfsite.org/pub/git/dracut.git
> > > 
> > > Wasn't the entire point to make the initramfs generic?
> > 
> > No, to make the initramfs generator generic. A subtle but important
> > distinction.
> 
> Nope. The plan was (quoting earlier mails to the list, from the
> creators...):
> 
> ...
> [I]nstead of scripts hard-coded to do various things, we depend on
> udev to create device nodes for us and then when we have the
> rootfs's device node, we mount and carry on

We do this just fine.  Udev is the engine that drives everything in a
dracut-generated initramfs -- the additional scripts are there in the
initramfs to handle things that udev does not handle gracefully. If you
see some functionality currently handles in a script that udev could
handle better, please implement it.

> ...
> There's another reason this is really useful.
> If something goes wrong, remotely debugging a users initrd right is
> a lot easier if you know what it looks like.  Right now, in Fedora for eg,
> where we generate an initrd for each users system at runtime, we need
> to get a copy of the generated initrd, and pull it apart just to find
> out what modules ended up in there, what didn't, and then somehow
> try to work backwards to try and figure out how the generator got into
> that state.  After doing this for five years, let me tell you it's
> _really_ _really_ painful.

Dracut should eventually be able to generate a single initramfs that
RHEL6 (for example) could distribute (per kernel, of course) that would
load on any supported server without having to be generated specifically
for that server. Assuming all you wanted to do was boot off a local
block device, we should be able to do that right now. 

> ...
> 
> And now we've got large patchsets that:
> - make the initramfs non-generic (in fact, machine-specific)

Yep.  Not everyone wants a generic does-everything initramfs. dracut is
flexible enough to handle their needs.

> - handle various device types through shell snippets, not udev
>   (raid, crypt, etc.)

We use shell snippets where udev is not flexible enough or where there
are other limitations we have to work around.  The entire process on the
initramfs is still udev driven, however.

> - farm everything out to random modules, so no initramfs is alike

That is up to whoever is generating the initramfs.  If someone wants to
tweak their initramfs, I have no problem letting them, and I do not
think dracut should get in their way.  At the same time, we want to be
able to generate an initrd that will work on darn near everything and
whose only customization can be through kernel parameters.

The current patching activity has been a little crazy, but we have
managed to take dracut from a Fedora-specifc proof of concept to
something that can build a working initramfs on fedora, suse, ubuntu and
(maybe) mandriva with minimal to no modification.  Not bad for a month's
mostly volunteer work.

> I think something's been lost here.
> 
> Bill
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
