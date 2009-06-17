From: Dave Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Redundant nfsroot cmdline options
Date: Tue, 16 Jun 2009 23:48:49 -0400
Message-ID: <20090617034849.GA22705@thedillows.org>
References: <4A36A510.5010709@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A36A510.5010709-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, Jun 15, 2009 at 03:46:24PM -0400, Warren Togami wrote:
> I am concerned about the proliferation of too many redundant ways of  
> configuring netboot.  We should clearly document each supported method  
> on this Wiki page and figure out which methods should be cut.  The most  
> obvious methods to cut are NEW inventions of dracut that are redundant  
> to other methods.

> root=nfs       nfsroot=...
> root=nfs4      nfsroot=...
> root=/dev/nfs4 nfsroot=...
>
> These are all new inventions in dracut, redundant to the following  
> native methods already supported.

These short cuts are simple, and fall naturally out of the current command
line parsing. I don't expect validating them to be any harder than the
translation I already do into the canoncical nfs[4]:IP:/path:options
format -- you validate the canonical. Documenting them is not very
difficult, either. Maybe there is a potential of user confusion, but you
hide them away in the "Legacy support" or "Non-recommended" appendix.

I simply don't see the problem.

But, I'm tired of having this same coversation every few days and I
don't care enough to continue it now. I'm not going to lose sleep if these
options are gone, so rip them out if that's your fancy.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
