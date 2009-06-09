From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: /dev/.initramfs copy state before switch_root
Date: Tue, 09 Jun 2009 01:18:43 -0400
Message-ID: <4A2DF0B3.8010301@redhat.com>
References: <4A2D8242.40205@redhat.com> <4A2DCFC3.7010606@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2DCFC3.7010606-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/08/2009 10:58 PM, Seewer Philippe wrote:
> I don't know if this is really necessary. After all, it just a static
> conf and initscripts can just check if an interface is already up?

NetworkManager or initscripts perhaps cannot differentiate between 
checking if it is already up immediately at boot-up or if it is run 
again sometime later.  It is really better for dracut to inform the OS 
explicitly in a uniform manner similar to if dhcp were used.

>
> Anyway, the syntax to use on the commandline is ip=... See
> http://apps.sourceforge.net/trac/dracut/wiki/commandline for more
> information.
>
> As for a file format, why not ask the NetworkManager people what they'd
> like to have?
>

Dan, what file format would you prefer?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
