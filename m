From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 15:26:26 -0500
Message-ID: <20090202202626.GB23009@nostromo.devel.redhat.com>
References: <20090202163708.GA27474@redhat.com> <20090202165736.GB29131@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202165736.GB29131-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dave Jones (davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said: 
> * selinux policy loading.
>   I don't think there's any real reason this has to be in the initrd.
>   Though it means that either upstart or whatever init you use has to
>   do it, or your /sbin/init needs to become
> 
>   #!/bin/sh
>   /usr/sbin/loadpolicy
>   /sbin/realinit
> 
> Thoughts?

While you can do the latter, it means that init (whatever version)
is packaged differently on distros wheter or not they support
SELinux. That's a little bizarre.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
