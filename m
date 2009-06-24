From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Netboot test suite: PXE instead of qemu -kernel?
Date: Wed, 24 Jun 2009 08:53:43 +0200
Message-ID: <4A41CD77.9030201@bfh.ch>
References: <4A410CA4.8030506@redhat.com> <1245819018.18861.3.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245819018.18861.3.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

David Dillow wrote:
[snip]
>> Additionally we could use -net tap* instead of -net socket, which would 
>> allow brctl setfd of a large value like 20 seconds to simulate the link 
>> delay in the test suite.
> 
> There is merit here, but I think we probably need to have a separate
> test suite to check the ip= option parsing. I haven't thought much how
> it should be done, other than it seems like we could use a pre-mount
> hook to check the configuration without needing to actually mount a real
> root.
> 
> If we have that test suite, then doing PXE boot or emulating BOOTIF=
> seems like a good idea. And I'd rather add a 20+ second delay to one or
> two tests here rather than every network root test we do.

I used an ugly copy of the nfs test suite to test ip= options handling. 
I'll try to make time this evening to clean it up and post it.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
