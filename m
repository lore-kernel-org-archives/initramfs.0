From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: ifup async race problem
Date: Thu, 11 Jun 2009 08:24:57 +0200
Message-ID: <4A30A339.1080900@bfh.ch>
References: <4A302B10.5040905@redhat.com> <1244675669.2871.7.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244675669.2871.7.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Victor Lowther wrote:
> On Wed, 2009-06-10 at 17:52 -0400, Warren Togami wrote:
>> modules.d/40network/60-net.rules
>>
>> ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"
>> ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/netroot $env{INTERFACE}"
>>
>> This works just fine if you have a single interface.  But if you have 
>> more than one interface bad things can happen.  If you have two or more 
>> interfaces and root=dhcp, the ifup udev rule attempts to dhclient on all 
>> interfaces simultaneously.
>>
>> This can be a problem in cases where two or more interfaces are on DHCP 
>> networks.  The udev rule kicked off both interfaces simultaneously, so 
>> there is no way to guarantee which of the two will succeed to mount the 
>> rootfs.  In my testing this means eth0 or eth1 unpredictably mounted the 
>> rootfs.  The other interface meanwhile is configured to an IP address 
>> and has routes added.  DNS and routes configured could be either 
>> interface as well.
>>
>> Locking so only one interface can ifup at a time wont exactly help here, 
>> because you still cannot predict which interface will go first.
>>
>> It seems we have no way to make it predictable (eth0 attempts before 
>> eth1) while doing ifup from a udev event?
> 
> My preferred solution would be to have the udev rule only grab
> configuration information (either from dhcp or ip= lines), and actually
> bring the interfaces up in the mount loop, where we can serialize them
> according to whatever the local netboot configuration requires.
> 
> Parallelizing the config information grabbing is a clear win (dhcp can
> take forever), but actually bringing up and taking down the interfaces
> is very fast once we actually have the information. :)

Exactly. Patch solving this is in the pipeline, I just need access to 
our lab to finish the tests. Hopefully that should be tomorrow.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
