From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: root=dhcp dhclient segfaulting on F-11
Date: Thu, 18 Jun 2009 09:32:31 +0200
Message-ID: <4A39ED8F.40000@bfh.ch>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch> <4A3924B9.2090303@redhat.com> <4A398A7C.40003@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A398A7C.40003-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
[snip]
> dhclient.eth0.567.out contains:
> + '[' -f /tmp/net..up ']'
> + netif=eth0
> + case $reason in
> + setup_interface
> ... (and it sets it up properly via DHCP)...
> ... (but eth0 is not configured by the time it hits the shell)...

Interface configuration is delegated to netroot now. So dhclient-script 
only writes config-files and does not actually configure the interface.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
