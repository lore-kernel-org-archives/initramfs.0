From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into
 its own series of hooks.
Date: Mon, 23 Feb 2009 18:44:11 -0600
Message-ID: <1235436251.28090.30.camel@sentry-no.fnordovax.org>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com>
	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>
	 <49A33E43.5010602@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=1y7XO+3eXpNT1S7G4iArE8zw8TULqWIHwvh/oopdfdU=;
        b=PfmLHLAGHMMiirmiBBLUDsrqiWJhBxIGeDbvdIWfJ5KooVQZggTaurRYcHXl48UDZO
         3BuUC89bc2UVeTZ2NZqWjx+Z1WT29wVaHqGiQ6MZJdYzt8ND/7bt46Bwg5+M79aJ38Vp
         eQPg8kpqUrgDW99XjxadxID70i20Fr+Io1nWA=
In-Reply-To: <49A33E43.5010602-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-02-23 at 19:24 -0500, Warren Togami wrote:
> Victor Lowther wrote:
> >> root=dhcp is a kernel cmdline given by the bootloader (syslinux, grub, 
> >> pxelinux, etc.) which directs the initrd during runtime to bring up eth0 
> >> and do DHCP.  It then mounts the rootfs depending on options given by 
> >> the DHCP server.  Fedora 10 mkinitrd implements the following two types 
> >> of mounts with root=dhcp.
> >>
> >>          option root-path "172.31.100.254:/path/to/target_root";
> >>          option root-path "nbd:172.31.100.254:2000:squashfs:ro";
> > 
> > Interesting -- I have been working on implementing code to detect and
> > configure network interfaces according to the netboot.txt kernel
> > document. The code I have written so far is browseable at
> > http://git.fnordovax.org/dracut/log/?h=network-configurability
> > (and it even works some of the time), and I would appreciate input from
> > someone who actually uses that functionality on a daily basis.
> 
> What is "netboot.txt document"?  Where is it from?

bleah -- I meant the kernel nfsroot.txt file -- located at
Documentation/filesystems/nfsroot.txt in the kernel tree.

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
