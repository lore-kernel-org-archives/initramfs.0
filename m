From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH 0/9] netroot: modular support for network root devices
Date: Mon, 1 Jun 2009 10:58:52 +0200
Message-ID: <4A23984C.5000006@bfh.ch>
References: <cover.1243833882.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Looks good!

David Dillow wrote:
> This builds on the NFS root work to allow other network methods to hook
> into the parsing and network infrastructure. One network interface is
> configured at a time, but if we don't find a root there, it may not be
> unconfigured -- this should probably be added.

This is a definite must. Actually, to support multiple interfaces we 
should even go so far and ensure that there is only one interface 
configured at any one time.

--> Consider the following case: Two interfaces and both receive a valid 
default route via dhcp. If we allow both interfaces to be configured 
after receiving the dhcp-reply, the second default-route will go byebye. 
I suggest to move the actual interface (de-)configuration into the 
netroot script.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
