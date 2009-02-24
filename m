From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 14:21:03 +0100
Message-ID: <49A3F43F.6000103@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>	 <49A301FF.2090303@redhat.com>	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>	 <49A3AB75.1010805@bfh.ch> <1235475578.28090.64.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235475578.28090.64.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Victor Lowther wrote:
[snip]
>> Though I see a small problem: Ever thought about what happens if there 
>> are multiple interfaces on different networks? Only one is valid to 
>> mount the root-fs... Currently I've solved that by upping each interface 
>> and then ping-testing the nfs-server... Any better ideas?
> 
> My current plan was to try and mount the NFS share forever, and maybe
> panic and die if a timeout option was passed as a kernel parameter.
> 
> Yes, I have thought about it, and have come to the conclusion that it is
> one of those problems that someone who actually uses it is better
> equipped to solve.  Writing the code to bring interfaces up and mount
> filesystems is generic, writing code to see if servers are responding
> depends on the environment -- the best way for me to handle it is to
> make it dead simple for site admins to handle it.

I agree, the ifup and mount should be pretty generic.

Browsing through the code a bit more thorougly throws up a few questions:

- 'dhclient -nw': Why are you starting the dhclient in daemon mode? 
Couldn't that pose problems when dhcp takes ages to acquire an adress? I 
mean like, we've ifup'ed all interfaces and are allready in the mount 
hooks without an ip. I guess we'd have to have a blocking mount-script 
waiting for at least one interface to be really brought up or spew an 
error message after a specific time out.

- default gw handling in dhclient-script: 'ip route add default' will 
fail if there's already another default route (Again the case of 
multiple interfaces). Would it be an idea not set a default route at all 
and let a mount-script handle this?

- I'd suggest adding something like if-pre-up.d, etc. Would make it easy 
to integrate wireless and/or wpa support.

- Why are you killing dhclient at the end?

Thanks for the great work!
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
