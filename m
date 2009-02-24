From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into
 its own series of hooks.
Date: Tue, 24 Feb 2009 05:29:24 -0600
Message-ID: <1235474964.28090.53.camel@sentry-no.fnordovax.org>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com>  <49A3A924.9000003@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=fjJR+ykPJ0C312LvDep1oOKdLoT4actRf8/aG7wk7hk=;
        b=tl1K84wkbYqpcjN8QWWAv7BXcK5Xe3FE0cncoBzomYboknf0/fzt77R1ucVVc49zJR
         WcnkhjrPnmwuxWGYLbjtVHkKZzlLjD2vypLNrBEO1kBKcxui0hqYDwRZc1h6B6QES2tv
         cgX+/odwYfMRHYK52nusDNNzqOl0sz+68t+6U=
In-Reply-To: <49A3A924.9000003-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-02-24 at 09:00 +0100, Seewer Philippe wrote:
> Hi all
> 
> Warren Togami wrote:
> [snip]
> > root=dhcp is a kernel cmdline given by the bootloader (syslinux, grub, 
> > pxelinux, etc.) which directs the initrd during runtime to bring up eth0 
> > and do DHCP.  It then mounts the rootfs depending on options given by 
> > the DHCP server.  Fedora 10 mkinitrd implements the following two types 
> > of mounts with root=dhcp.
> > 
> >         option root-path "172.31.100.254:/path/to/target_root";
> >         option root-path "nbd:172.31.100.254:2000:squashfs:ro";
> > 
> > An existing RFC specifies syntax for iscsi that could be implemented as 
> > well.  (Although iscsi is problematic because some types require 
> > authentication.)  Arbitrary types of root=dhcp rootfs mounts can be 
> > implemented with hooks made possible with your patch.
> 
> A question: Why not use root=/dev/nfs and the other options according to 
> kernel doc, like nfsroot=... and ip=autoconf? For me that is much more 
> readable.

It is a matter of taste and historical contingency, I suppose.  The
current nfsroot mounting stuff was added way before initramfs/initrd was
an option, and it was probably easier to not mess up the in-kernel root=
handling code (which expected a device to mount).  Since initramfs
handles all that stuff now (assuming you are using it, of course), the
kernel neither knows nor cares about the contents of the root=
parameter, and we do not have to be bound by its restrictions. We can
make (for example) root=192.168.10.2:/my/root/path do The Right Thing
and mount that as an nfs filesystem.  We would still handle the other
case, of course.

> Maybe even leave nfsroot-mounting to the kernel as long as that features 
> remains in the tree.

That is impossible when using an initramfs.  Once the kernel notices an
initramfs, finds /init on it and execs it, it is up to the initramfs to
handle everything else.

> I guess nbd and iscsi could go the same way like root=/dev/iscsi ...

It is as easy to handle it one way or the other in userspace.  I happen
to think that overloading root= is easier to read, and prevents having
to remember yet another *root parameter when someone invents an even
more convoluted and crazy way to store a filesystem. :) 

> Regards,
> Philippe
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
