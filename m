From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Passing dhclient leases through switch_root
Date: Wed, 03 Jun 2009 17:31:57 -0400
Message-ID: <4A26EBCD.4010800@redhat.com>
References: <4A244FF4.9040905@redhat.com> <1243896410.647.35.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243896410.647.35.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/01/2009 06:46 PM, Victor Lowther wrote:
>
> None here.  We should do something along those lines for /tmp if we were
> asked to debug the initrd.
>

If netboot, copy /tmp/net.* for the boot interface to
/dev/.boot/

This is for the use of anything in the booted system that needs to be 
aware of what network was brought up during initrd.

If cmdline rdcopystate, then copy all of /tmp/* into
/dev/.boot/

This is primarily for debugging purposes.

Thoughts?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
