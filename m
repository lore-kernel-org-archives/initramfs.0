From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Wed, 27 May 2009 23:00:01 -0400
Message-ID: <4A1DFE31.1060301@redhat.com>
References: <1243126816.4217.248.camel@obelisk.thedillows.org> <4A1DB696.9060807@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1DB696.9060807-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/27/2009 05:54 PM, Warren Togami wrote:
>> root=/dev/nbd[0-9]* nbdroot=server.ip.add.ress,port[,nbd basedevice]
>
> This is from Andreas' suggested patch for nbd root, where this is the
> third supported method of booting nbd. I think we should DROP this. The
> reason for this is it used to be necessary to define a specific nbd
> device number because old versions of nbd-client did not have a method
> to detect if a nbd device is already connected and in-use. Modern
> versions do not have this problem. Code using it simply iterates looking
> for the first unused nbd device.
>
> The ability to specify a nbd mount point with cmdline should be using
> the new syntax. We should drop this old syntax because it is redundant,
> and more error prone.
>

While I don't care so much if the other legacy methods go into dracut, I 
might suggest strongly against including this one.  In addition to the 
other reasons:

* It was never used with DHCP root-path in the past.
* It relied on other hard-coded things that you don't see to specify the 
filesystem type and aufs/unionfs layering on top.  Note that it doesn't 
include filesystem type and mount options.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
