From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 13 NFS syntax variations
Date: Tue, 23 Jun 2009 00:15:38 -0400
Message-ID: <4A4056EA.9010102@redhat.com>
References: <4A39A9AF.6070009@redhat.com> <4A3A13A8.6050100@bfh.ch>	 <4A3FEFE7.7080907@redhat.com> <1245709757.13352.20.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245709757.13352.20.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/22/2009 06:29 PM, David Dillow wrote:
>> 3) Support it but print deprecation warnings like Legacy nfsroot.txt.
>
> This would be my choice; the DHCP (BOOTP) root-path=[server:]/root-path
> formats have been around for decades. I seem to recall network booting a
> SunOS 4.1.2 box using that back in 1993, and I'll bet it wasn't a new
> feature then.
>
> Some changes I'm thinking about would benefit from dropping the non nfs:
> formats, as they wouldn't have a clean home otherwise, but I don't think
> that is a good reason to drop them -- they are too easy to support.

root=<server-ip>:/path:nfs-options

Yes, I am aware it has existed for decades.  However neither Red Hat nor 
Debian's tools supported this method.[1]  This seems to make it a good 
candidate for chopping.

Harald, what do you think?

[1]
mkinitrd supports it only partially, without nfs-options, and without a 
method to auto-load network drivers prior to NFS, meaning nobody used it.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
