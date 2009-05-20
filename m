From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] LIBDIR detection without /proc
Date: Wed, 20 May 2009 22:52:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905202249560.7805@gate.bb.dicp.net>
References: <4A146687.3020508@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A146687.3020508-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 20 May 2009, Warren Togami wrote:

> Could we please not rely on /proc to detect anything?  Something like 
> the following would work fine.  It also has the benefit of being able to 
> run without /proc mounted, which is great for building initrd's within a 
> chroot.

I'm not sure if checking for an installed file is going to work flawless.
*shrug*


> Another issue, it appears this plymouth module is uncondtional? 
> Shouldn't it skip plymouth install if it plymouth does not exist for the 
> sake of other distributions?

[root@bofh dracut]# cat modules.d/50plymouth/check
#!/bin/bash
[[ -x /sbin/plymouthd && -x /bin/plymouth && -x /usr/sbin/plymouth-set-default-theme ]]
[root@bofh dracut]# 

Does look rather conditional to me.

regards, 
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
