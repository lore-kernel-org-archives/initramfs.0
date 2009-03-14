From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 0/2] dracut, udev and complicated netboot cases
Date: Sat, 14 Mar 2009 17:32:12 +0100
Message-ID: <49BBDC0C.9020900@bfh.ch>
References: <49BBA8A7.4010903@bfh.ch> <1237047349.14649.252.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237047349.14649.252.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Victor Lowther wrote:
> You shoudl save the additional dhcp options, so that people who want to
> do their fs mounting based on parameters provided by dhcp can do that.  

Good point. Save it in a sourceable scriptfile or just let dhclient
create a leasefile?


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
