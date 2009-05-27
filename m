From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Move logs and other runtime created files into /tmp
Date: Wed, 27 May 2009 17:35:58 -0500
Message-ID: <2CADAB23-C078-4651-9CF9-F4B4F096A682@gmail.com>
References: <4A1DA52E.7080009@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=6UrJ0dotUXXyRn7z1z0UeGStLNS7QZPC/sgyq2M/2sA=;
        b=hCH5EfXI/1GNVZI63q2OBhW3FCnWTjbTSfBlOGcf3VVjdd9MDq6ZVRq3eeuwjMPC/e
         50vr/EbPsx/kkWLF0jYlZcgYr1P0j7XICVPuKY9v8Imt1G9fRTYx+MxgMi+JfY+BuPb4
         AGDWDXOm4UE77HyLL3uKAzCRnHNNl2ZEdzP30=
In-Reply-To: <4A1DA52E.7080009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On May 27, 2009, at 3:40 PM, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> nfs*
> net*
> dhclient*
>
> Any objections to moving all these files that are created during  
> runtime from / into /tmp?  It makes it a bit more obvious at a  
> glance what came shipped in the initrd and what was written during  
> runtime.
>
> If nobody objects I am pushing this change in a few hours.

Sounds like a winner. As a bonus, it makes it easier to add a debug  
option that copies all the generated files to somewhere on the real  
root.

>
> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
