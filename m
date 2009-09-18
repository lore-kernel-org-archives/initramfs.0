From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Please revert commit "There is only one resolv.conf."
Date: Thu, 17 Sep 2009 23:38:32 -0400
Message-ID: <4AB300B8.4090307@redhat.com>
References: <4AB254A3.5000302@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AB254A3.5000302-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/17/2009 11:24 AM, Seewer Philippe wrote:
> Having only one resolv.conf is ok for a booted client. That is the
> normal and the usual behaviour is that the first interface to be up and
> ready with data is the one to write the contents.
>
> But inside dracut we really do not want that behaviour. First the
> primary interface (see bootdev cmdline argument) might not be the first
> interface to come up, second if we are in guess-the-interface mode,
> multiple interface might receive different data for resolv.conf and we
> have to use the correct stuff to mount.
>
> So please revert that commit.

Do you agree the one copied ultimately should be the interface that 
successfully netbooted?

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
