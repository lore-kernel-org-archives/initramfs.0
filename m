From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 16:39:57 +0100
Message-ID: <49A414CD.8070204@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com> <49A301FF.2090303@redhat.com>	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>	 <49A3AB75.1010805@bfh.ch> <1235475578.28090.64.camel@sentry-no.fnordovax.org> <49A3F43F.6000103@bfh.ch> <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Victor Lowther wrote:
[snip]
>> - 'dhclient -nw': Why are you starting the dhclient in daemon mode? 
>> Couldn't that pose problems when dhcp takes ages to acquire an adress? 
>> I mean like, we've ifup'ed all interfaces and are allready in the 
>> mount hooks without an ip. I guess we'd have to have a blocking 
>> mount-script waiting for at least one interface to be really brought 
>> up or spew an error message after a specific time out.
> 
> I run it in daemon mode so that udev does not have to wait on it. The 
> dhclient-script creates a file when the interface is up, and any mounts 
> that depend on the network can wait for those files to appear. ifup does 
> the same thing with static interfaces.

I don't like the asynchronousnes of this. This means we have to wait in 
pre-mount or mount until we have at least one interface up without any 
knowledge if another might come up later as well.

>> - default gw handling in dhclient-script: 'ip route add default' will 
>> fail if there's already another default route (Again the case of 
>> multiple interfaces). Would it be an idea not set a default route at 
>> all and let a mount-script handle this?
> 
> How would the mount script know how to handle this?

DHCP lease data is stored in a lease file. if a default-route is sent, 
then there's an entry for that in the lease file.

>> - I'd suggest adding something like if-pre-up.d, etc. Would make it 
>> easy to integrate wireless and/or wpa support.
> 
> I have no particular plans to add this type of support, but patches are 
> welcome.

Will do.

> 
>> - Why are you killing dhclient at the end?
> 
> Because I have no idea how well of handles its root filesystem 
> vanishing, and all I care about it doing is getting the interface 
> configured. I do not care about long-term link management.

Ah, ok! thanks!
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
