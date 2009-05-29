From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut generation modes
Date: Fri, 29 May 2009 07:12:56 -0500
Message-ID: <1243599176.31156.20.camel@sentry-no.fnordovax.org>
References: <4A1EDEBF.4080009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=T6kI/i39gSjzS1kBFG0ExiGZLC+AqUfmoNwKhP/sx7s=;
        b=lJkqbXJEiKjUm1FXZDLmeisedMw6897QApELudQ7lucGF6apeazzEIDSrUIF/7Lmpk
         H2aHcIpMpBJIvYcPt6mKpYbDrWJPgT+ixZoCU0diYT5P2tg55VOg+0A0dJu1cltMxskT
         sjOl1F0dqJ9nLBd2PX4qT77Lp62DQMM4e3Nns=
In-Reply-To: <4A1EDEBF.4080009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-05-28 at 14:58 -0400, Warren Togami wrote:
> So this might not have been clear earlier, but stating it on the list to 
> be sure everyone is on the same page.
> 
> * Default Dracut
> Dracut without any parameters should generate an initrd image capable of 
> booting a generic machine.  This means it must not detect anything of 
> the current running system to determine what to install in the image. 
> This includes stuff in /proc, /sys, lsmod, /proc/mounts and possibly more.
> 
> By necessity, stuff in the filesystem are usable to dracut in 
> determining what to install in the image.

Should "default" dracut include networking modules, nfs/nbd/iscsi boot
code, etc?  My first instinct would be to say no -- the overwhelming
majority of systems will not need that code to boot.

Heck, I would say that --hostonly should be the default mode, and
generating a generic image should be a special option.

> * --hostonly mode
> Host only mode is permitted to use runtime detection to generate an 
> image capable of booting the current system.  What exactly does this 
> mean?  Is this primarily for smaller sizes by avoiding irrelevant modules?

Yes.  Larger initramfs'es take longer to load into memory, uncompress,
and boot, and there seems to be an odd emphasis on fast boots these
days.

> * (Some other generation mode)
> Perhaps we need more generation modes for other purposes.  One likely 
> case is where you need to generate a machine specific image for a 
> non-local system.  A combination of command line options and/or .conf 
> file would define the dracut image for a non-local system.  This might 
> be necessary for cases like:
> 
> - netboot initrd needs to be as small as possible for resource 
> constraint reasons
> - embedded systems with resource constraints
> - certificates or passwords for iscsi or kerberized nfs

Yes, these reasons are why dracut can source its .conf file from
multiple locations.

For especially tricky scenarios, the kernel can load more than one
initramfs and overlay later ones on top of earlier ones.  I considered
making dracut use that functionality more explicitly by having each
dracut module generate its own compressed cpio, but that would be too
great a departure from how virtually every bootloader handles things to
be worth it. Now you know why I added the -i feature. :)

> How should this mode be specified from the command line?

My idea is to have several dep-only modules in dracut now that we have
dep checking for dracut modules.

-d nfsroot would pull in all the modules needed to boot off nfs, 
-d iscsi would do the same sort of things for iscsi, and so on.

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
