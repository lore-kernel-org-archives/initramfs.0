From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 2/5] Give the kernel some time to up interfaces
Date: Fri, 26 Jun 2009 09:07:38 +0200
Message-ID: <4A4473BA.1020301@bfh.ch>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>	 <1245866912-3643-3-git-send-email-philippe.seewer@bfh.ch> <1245985355.30948.14.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245985355.30948.14.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
> On Wed, 2009-06-24 at 20:08 +0200, Philippe Seewer wrote:
>> It does not really matter if the kernel needs some time or if
>> the ethernet handshake takes a while. It's a good idea to wait
>> a second after upping an interface to let things settle.
> 
> Hmm, shouldn't DHCP retries take care of this issue, and the server ARP
> ping we've been talking about take care of it for static configs?
> 
> I would be a bit concerned that the backoff of dhclient may slow us down
> more than a second, but I've not investigated if that is true.
> 
> I'm not really keen on adding a mandatory delay unless there is no other
> option.
> 

In the DHCP case, yes we could skip the sleep as dhclient will just
retry if the interface isn't ready. But for all other cases, we really
should give the hardware some time to initialize. 

During the years, I've had to use this for different cases, be it
slow firmware loading, weird drivers or just hardware that takes
longer. I've even had interfaces failing configuration if they didn't 
get some time to initialize. Another example: My e1000e card actually
takes just a bit more than 1 second to got to LOWER_UP when I do
modprobe e1000e && ip link set eth0 up

So this patch is just plain paranoia to make sure there's enough time
between upping the interface and trying to configure it. Yes, we could 
try to wait for LOWER_UP or something similar, but sleep 1 is simpler
and I haven't yet seen a case where that isn't enough and the slow down
is negligible.

As for other references: Stock isc 4.1 dhclient-scripts do it as well
for example. I admit, others doing it doesn't make it right. But it's 
just a pointer.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
