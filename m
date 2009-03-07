From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Sat, 7 Mar 2009 09:40:25 +0100
Message-ID: <49B232F9.2000008@bfh.ch>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org> <20090306203921.GA28154@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090306203921.GA28154-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Bill Nottingham wrote:
[snip]
> ...
> 
> And now we've got large patchsets that:
> - make the initramfs non-generic (in fact, machine-specific)
> - handle various device types through shell snippets, not udev
>   (raid, crypt, etc.)
> - farm everything out to random modules, so no initramfs is alike
> 
> I think something's been lost here.

Just my 50 cents: The past few weeks have really been focused on 
creating a basic dracut infrastructure and getting various crazy and 
convoluted system-configurations to boot with a dracut _generated_ 
initramfs. And we're not even finished with that yet.

I view the current state as "collecting information" and prototyping to 
know which things need to be done inside the initrd and test out various 
combinations in how that can be done. But we're still a few steps from 
"the initrd of total domination".

Regards,
Philippe

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
