From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its own series of hooks.
Date: Tue, 24 Feb 2009 08:19:14 -0600
Message-ID: <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45@gmail.com>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com> <49A301FF.2090303@redhat.com>	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>	 <49A3AB75.1010805@bfh.ch> <1235475578.28090.64.camel@sentry-no.fnordovax.org> <49A3F43F.6000103@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=al+853I3E4r31RLKdtB3Cxx7aKdYhz72opP1Xl+mQR8=;
        b=vCRKpJsffCqYzuAYFZTrY7ZSaFfycXL7y2RSgQFwsGiiZuClsYvIyP67kQp9gO+pPh
         u9Lw241Opv1wIYDukXx/QPV8AKWiFqBR5HS3Tn5tjg8eNDatxgtaDgWf8A+VvRHswl09
         QHte0GCe+ettf3Ep/0SnKAfn3I80KhJF4qyyc=
In-Reply-To: <49A3F43F.6000103-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Feb 24, 2009, at 7:21 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

>
>
> Victor Lowther wrote:
> [snip]
>>> Though I see a small problem: Ever thought about what happens if  
>>> there are multiple interfaces on different networks? Only one is  
>>> valid to mount the root-fs... Currently I've solved that by upping  
>>> each interface and then ping-testing the nfs-server... Any better  
>>> ideas?
>> My current plan was to try and mount the NFS share forever, and maybe
>> panic and die if a timeout option was passed as a kernel parameter.
>> Yes, I have thought about it, and have come to the conclusion that  
>> it is
>> one of those problems that someone who actually uses it is better
>> equipped to solve.  Writing the code to bring interfaces up and mount
>> filesystems is generic, writing code to see if servers are responding
>> depends on the environment -- the best way for me to handle it is to
>> make it dead simple for site admins to handle it.
>
> I agree, the ifup and mount should be pretty generic.
>
> Browsing through the code a bit more thorougly throws up a few  
> questions:
>
> - 'dhclient -nw': Why are you starting the dhclient in daemon mode?  
> Couldn't that pose problems when dhcp takes ages to acquire an  
> adress? I mean like, we've ifup'ed all interfaces and are allready  
> in the mount hooks without an ip. I guess we'd have to have a  
> blocking mount-script waiting for at least one interface to be  
> really brought up or spew an error message after a specific time out.

I run it in daemon mode so that udev does not have to wait on it. The  
dhclient-script creates a file when the interface is up, and any  
mounts that depend on the network can wait for those files to appear.  
ifup does the same thing with static interfaces.

> - default gw handling in dhclient-script: 'ip route add default'  
> will fail if there's already another default route (Again the case  
> of multiple interfaces). Would it be an idea not set a default route  
> at all and let a mount-script handle this?

How would the mount script know how to handle this?

> - I'd suggest adding something like if-pre-up.d, etc. Would make it  
> easy to integrate wireless and/or wpa support.

I have no particular plans to add this type of support, but patches  
are welcome.

> - Why are you killing dhclient at the end?

Because I have no idea how well of handles its root filesystem  
vanishing, and all I care about it doing is getting the interface  
configured. I do not care about long-term link management.

> Thanks for the great work!
> Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
