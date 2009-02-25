From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into	its
 own series of hooks.
Date: Wed, 25 Feb 2009 08:25:29 +0100
Message-ID: <49A4F269.3030304@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com> <49A301FF.2090303@redhat.com> <1235434056.28090.28.camel@sentry-no.fnordovax.org> <49A3AB75.1010805@bfh.ch> <1235475578.28090.64.camel@sentry-no.fnordovax.org> <49A3F43F.6000103@bfh.ch> <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45@gmail.com> <49A414CD.8070204@bfh.ch> <20090224185034.GA1834@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090224185034.GA1834-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Jeremy Katz wrote:
> On Tuesday, February 24 2009, Seewer Philippe said:
>> Victor Lowther wrote:
>> [snip]
>>>> - 'dhclient -nw': Why are you starting the dhclient in daemon mode?  
>>>> Couldn't that pose problems when dhcp takes ages to acquire an 
>>>> adress? I mean like, we've ifup'ed all interfaces and are allready in 
>>>> the mount hooks without an ip. I guess we'd have to have a blocking  
>>>> mount-script waiting for at least one interface to be really brought  
>>>> up or spew an error message after a specific time out.
>>> I run it in daemon mode so that udev does not have to wait on it. The  
>>> dhclient-script creates a file when the interface is up, and any mounts 
>>> that depend on the network can wait for those files to appear. ifup 
>>> does the same thing with static interfaces.
>> I don't like the asynchronousnes of this. This means we have to wait in  
>> pre-mount or mount until we have at least one interface up without any  
>> knowledge if another might come up later as well.
> 
> The problem is that the appearance of devices *is* asynchronous and you
> have to keep things as event driven.  That's why originally everything
> was being driven off of udev rules rather than hooks.  If you start
> trying to do things in hooks and assume synchronous behavior, boot will
> be slower and you also can't have, eg, usb devices being used (usb plug
> events are always async; anything else is an illusion)

That is of course correct. Though in the case of a netboot I'd like to 
argue that we absolutely need to make sure that networking is correctly 
set up before trying to mount anything. So making it synchronous makes 
the whole a lot easier to control.

And to be honest, with netboot I don't think boot time matters all that 
much. The bottleneck will always be dhcp and the net itself.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
