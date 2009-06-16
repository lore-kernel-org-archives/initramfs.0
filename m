From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: including python in the initramfs
Date: Tue, 16 Jun 2009 14:26:07 -0400
Message-ID: <4A37E3BF.3050903@redhat.com>
References: <1245174031.2150.67.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245174031.2150.67.camel@polyethylene>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/16/2009 01:40 PM, Daniel Drake wrote:
> One idea: we could create a separate module which installs all the files
> identified by "rpm -q --filesbypkg python". But that's obviously not
> distro-portable. It could work for us but I'd prefer that we're able to
> share the work we're doing with others. Any other ideas?

Aside from the other reasons this is a bad idea, you cannot safely do 
rpm queries for this if you intend on the initrd to ever be built from 
an rpm scriptlet like %post.  The rpmdb locking will cause problems.

Is it really not possible to run the security client after initrd?

What does the security client do?

Warren


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
