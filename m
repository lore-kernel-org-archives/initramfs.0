From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Please revert commit fa0115c3c06176bd0fdfcd8966021979ec84f3d7
Date: Wed, 24 Jun 2009 08:59:38 +0200
Message-ID: <4A41CEDA.9020504@bfh.ch>
References: <4A408358.7050706@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A408358.7050706-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe wrote:
> Commit fa0115c3c06176bd0fdfcd8966021979ec84f3d7 moved calling
> cryptsetup from the mount hook to inside a udev rule. While this is a 
> good idea it causes more problems than it solves:
> 
> cryptsetup version 1.6 (and possibly earlier versions) calls
> 'udevadm settle' on it's own. This must not be done from inside
> udev rules as it potentially results in a deadlock depending
> on udev version.

A short amendment to this:

- Fedora cryptsetup is patched, removing the udevadm settle altogether.
That's why it was working for most of you. (Thanks to Warren for helping
to debug this)

- In addition I don't think its a good idea to include anything in a
udev-rule that does user interaction, since udev has an built-in
event-timeout.

> 
> Thank you,
> Philippe
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
