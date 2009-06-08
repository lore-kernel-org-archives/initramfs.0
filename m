From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Install debian renamed udev rules as well
Date: Mon, 8 Jun 2009 22:57:27 +0200
Message-ID: <4A2D7B37.8080502@bfh.ch>
References: <4A2D2BD4.1000504@bfh.ch> <20090608191550.GA11215@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090608191550.GA11215-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Jeremy Katz wrote:
> On Monday, June 08 2009, Seewer Philippe said:
>> Debian has reworked/renamed quite a few default udev rules.
> 
> The last time this came up, the conclusion was that the dracut upstream
> shouldn't be hacked to workaround the fact that Debian deviates from
> upstream udev.  Kay even felt pretty strongly about it, iirc.

I know, I know. I think I heard the rambling a few times on IRC.

But: It's not a hack and not even a workaraound. It's just two files 
that may be copied if they are there. So I thought maybe its OK...

> Debian is currently the only major distro that isn't just shipping the
> upstream defaults...

Well, I really need (want?) Debian support in dracut. If you're not 
happy with that, what about a debian specific module? Would result in 
more or less the same but wouldn't clutter up a "normal" dracut module.

Regards,
Philippe

> 
> Jeremy
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
