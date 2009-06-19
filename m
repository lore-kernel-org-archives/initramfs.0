From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Files copied from generating system
Date: Thu, 18 Jun 2009 23:00:35 -0400
Message-ID: <1245380435.28792.13.camel@lap75545.ornl.gov>
References: <4A3AA2CA.7000507@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A3AA2CA.7000507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-06-18 at 16:25 -0400, Warren Togami wrote:
> We can't really predict the behavior of or support initrd's that end up 
> with whatever customized config files are copied from the system, but 
> options for dealing with this problem are not clear.  Any ideas?
> 
> modules.d/95nfs/install:
> > /etc/nsswitch.conf
> > /etc/idmapd.conf
> 
> These could possibly be edited and cause NFS to behave unexpectedly in 
> the initrd.

rpc.idmapd and /etc/idmapd.conf can probably go away, since it was
decreed that we only have to mount the root filesystem and the distro
has to worry about getting ID mapping working before using a non-root
user.

nsswitch.conf is more difficult, but if you are relying on DNS, NIS, or
LDAP to find your network root, this is a concern you should probably be
aware of.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
