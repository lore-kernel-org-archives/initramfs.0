From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Wed, 27 May 2009 22:41:12 -0500
Message-ID: <1243482072.2806.4.camel@sentry-no.fnordovax.org>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
	 <4A1DB696.9060807@redhat.com>
	 <1243470194.23466.32.camel@obelisk.thedillows.org>
	 <4A1DFC8B.2060700@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=EhkmP5IiTOxJWSsxDHW/hoS26C2O/7VVgvoIiF/snUw=;
        b=JlWQUT1Thr2Lnt0u0rKhKUkoOwOcs/H1NtABSh9KMHEviSD2iQYr8FYSvSsPyu7ZPQ
         EeVhNMCWgk4TRUu88lWLAra6py/eBLbsehn6jnUmqKciX+O/xJUf8otN+NfMZmvglb8y
         BcDd24fp3VGDiP+0KST5Gmx99F8/0PY+oz7FU=
In-Reply-To: <4A1DFC8B.2060700-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-05-27 at 22:52 -0400, Warren Togami wrote:
> On 05/27/2009 08:23 PM, David Dillow wrote:
> >> Options:
> >> 1) Re-implement it entirely in dracut without relying on the kernel
> >> implementation.  But will it work?  The kernel seeing root=/dev/nfs will
> >> try to do its own thing anyway?
> >> 2) Drop this entirely.  If somebody chooses to use this method of nfs
> >> boot dracut isn't involved.
> >
> > Well, yes, Warren. If the kernel has CONFIG_ROOT_NFS set and sees these
> > options, I expect the initrd will not be used. But I don't think any
> > distro that dracut would support has this set. Certainly it has caused
> > no problems in my writing and testing the nfsroot code I did last month.

If an initrd/initramfs is used, the kernel will not check any root=
arguments, nfs or otherwise (IIRC).

> OK, I personally am not interested in this behavior.  I will leave it up 
> to others if dracut should support it.
> 
> >
> >>> * DHCP root-path option, with varying forms
> >>> 	Using next-server or server-id opt and root-path as pure path:
> >>> 		${next_server-${server_id}}:${root_path}
> >> This particular method is ambiguous, why next-server or server-id?
> >
> > If next-server is set, use it. If not, use server-id. This method has
> > been long used and is unambiguous.
> 
> Ditto.
> 
> >
> >> I think we should seriously consider that we shouldn't be concerned with
> >> every possible legacy method of setting up nfsroot.  Each generation of
> >> software has the opportunity to configure itself in the way that it
> >> needs.  What scenarios are there where this isn't true?
> >>
> >> I mean, if you use old software, don't use dracut.
> >
> > This isn't about using old software, it is about allowing old
> > configuration methods to work so that dracut can be a drop in
> > replacement. I'm not saying these are all good ways to do it, or that we
> > necessarily need to support all of them, but if they are easy to map to
> > our solution once we choose it, then it makes sense to do so.
> >
> > It's nice when software is usable without having to read all of the
> > documentation -- in many ways, this allows a dracut-enabled distro to be
> > dropped into place in an existing DHCP environment, which may have
> > thousands of nodes using the existing syntax.
> 
> The dracut documentation should reduce confusion by describing one 
> official syntax.  I'll leave it up to others to decide if dracut should 
> support legacy/deprecated syntaxes.  I guess I don't care too much to 
> fight it.

We should support legacy syntax where it makes sense, at least.

However, I would rather see a working release kicked out the door for
people to play with than start prematurely arguing over arcane details
most of the world does not care about in the name of elegance.

> >
> >>> * What about multiple devices?
> >> AFAIK nothing out there supports booting from the second interface.  Am
> >> I wrong?
> >
> > gedi-tools.sf.net will boot from whatever interface and remap it to
> > eth0. You yourself were complaining about issues with wireless. I have
> > several machines in which the interface they should boot of off is not
> > eth0, and it is not possible to swap the order of the cards.
> >
> > Besides, it is already implemented, sans bugs from my forward port.
> 
> OK, another case where I don't care about it, as long as other people 
> make the code work.
> 
> Might I ask though, if no ip= line is supplied, assume dhcp and use only 
> whatever it thinks is eth0.

Only if doing something else that requires the network to work.
Bringing up the network interface in the initramfs when booting from a
local block device is decidedly suboptimal. :)

> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
