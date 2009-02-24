From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 09:10:29 +0100
Message-ID: <49A3AB75.1010805@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>	 <49A301FF.2090303@redhat.com> <1235434056.28090.28.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235434056.28090.28.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Victor

[snip]
> Interesting -- I have been working on implementing code to detect and
> configure network interfaces according to the netboot.txt kernel
> document. The code I have written so far is browseable at
> http://git.fnordovax.org/dracut/log/?h=network-configurability
> (and it even works some of the time), and I would appreciate input from
> someone who actually uses that functionality on a daily basis.
Looks good. I'm actually considering replacing our own initrd with this 
one when we upgrade our netboots to 2.6.29.

Though I see a small problem: Ever thought about what happens if there 
are multiple interfaces on different networks? Only one is valid to 
mount the root-fs... Currently I've solved that by upping each interface 
and then ping-testing the nfs-server... Any better ideas?

Thanks,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
