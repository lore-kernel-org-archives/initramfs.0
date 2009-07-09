From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Warn if defaulting to ip=dhcp
Date: Thu, 09 Jul 2009 16:44:17 -0400
Message-ID: <4A5656A1.90703@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

99parse-ip-opts.sh:
> # Warn if defaulting to ip=dhcp
> if [ -n "$netroot" ] && [ -z "$(getarg ip=)" ] ; then
>     warn "No ip= argument(s) for netroot provided, defaulting to DHCP"
>     return;
> fi

Is this really necessary?  This is not a warning.  There is nothing 
wrong with this.  Any objections to just removing this?

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
