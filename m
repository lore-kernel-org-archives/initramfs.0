From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its 
	own series of hooks.
Date: Tue, 24 Feb 2009 15:37:22 +0100
Message-ID: <ac3eb2510902240637l3b720c4ewf9a2c5ee6a201011@mail.gmail.com>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com>
	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>
	 <49A3AB75.1010805@bfh.ch>
	 <1235475578.28090.64.camel@sentry-no.fnordovax.org>
	 <49A3F43F.6000103@bfh.ch>
	 <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Feb 24, 2009 at 15:19, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Feb 24, 2009, at 7:21 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org> wrote:

>> - Why are you killing dhclient at the end?
>
> Because I have no idea how well of handles its root filesystem vanishing,
> and all I care about it doing is getting the interface configured. I do not
> care about long-term link management.

Which makes a lot of sense. We usually do not want to leave any
process/service from initramfs staying around, but kill and delete all
of them behind us, if we enter the real root, and start all
processes/services from the real rootfs instead.

Everything else would create a real hard to debug setup if something
goes wrong. We may have different setups/configs/versions/environments
in the real rootfs and the initramfs image.

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
