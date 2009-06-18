From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How to find the root partition with root=dhcp root-path=iscsi:::...
Date: Thu, 18 Jun 2009 13:29:13 -0400
Message-ID: <4A3A7969.3020502@redhat.com>
References: <4A3A4F8F.8070204@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3A4F8F.8070204-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/18/2009 10:30 AM, Harald Hoyer wrote:
> If we have root=dhcp and root-path from dhcp with "iscsi::... " nothing
> is know about the partition where root lives in.
>
> RFC:
> provide a pre-mount fallback, which tries to mount
>
> /dev/disk/by-label/\x2f (LABEL=/)
> /dev/disk/by-label/ROOT (LABEL=ROOT)
>

BTW, I'm not against this as a fallback, but am I incorrect about root= 
being explicitly usable with netroot=dhcp?

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
