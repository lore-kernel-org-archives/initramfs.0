From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 2/5] Give the kernel some time to up interfaces
Date: Thu, 25 Jun 2009 23:02:35 -0400
Message-ID: <1245985355.30948.14.camel@obelisk.thedillows.org>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
	 <1245866912-3643-3-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245866912-3643-3-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-06-24 at 20:08 +0200, Philippe Seewer wrote:
> It does not really matter if the kernel needs some time or if
> the ethernet handshake takes a while. It's a good idea to wait
> a second after upping an interface to let things settle.

Hmm, shouldn't DHCP retries take care of this issue, and the server ARP
ping we've been talking about take care of it for static configs?

I would be a bit concerned that the backoff of dhclient may slow us down
more than a second, but I've not investigated if that is true.

I'm not really keen on adding a mandatory delay unless there is no other
option.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
