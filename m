From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Install debian renamed udev rules as well
Date: Mon, 8 Jun 2009 15:15:51 -0400
Message-ID: <20090608191550.GA11215@redhat.com>
References: <4A2D2BD4.1000504@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A2D2BD4.1000504-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Monday, June 08 2009, Seewer Philippe said:
> Debian has reworked/renamed quite a few default udev rules.

The last time this came up, the conclusion was that the dracut upstream
shouldn't be hacked to workaround the fact that Debian deviates from
upstream udev.  Kay even felt pretty strongly about it, iirc.

Debian is currently the only major distro that isn't just shipping the
upstream defaults...

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
