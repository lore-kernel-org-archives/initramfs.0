From: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Wed, 13 Nov 2013 23:45:00 +0600
Message-ID: <CAN_LGv0XtGtsweN1AmRY26rrXNo7BL3GEOc3xPZOq_qhzOJP5g@mail.gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
	<52830E31.30107@gmail.com>
	<CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>
	<5283AEA4.9050209@colin.guthr.ie>
	<CAN_LGv2H3pDZ+Sp6LpxkN+Ay_4LbZbR4Av1_j0B2WLO=TcxvAw@mail.gmail.com>
	<5283B76B.8070902@colin.guthr.ie>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y3VnOofzpPXDqrLwspHLDBPS0ChW4Gtlt96e+yJK8P4=;
        b=st0UW8aHHc+s8EIKk1Q6sZOuF3zScp2pW0yzXm0P5yAtIj6UkZZ5+678uHBY+f6rcR
         ySed6x5R2UBgqsdG3NUWtKc1OkQlv91Fm6h9LudPAy1XlSvpd7TcBz9Y56T3Iuvuv36n
         LZCj9T8/T0GVlTjlJB950Nd2Qa58imIRMH5N9EgpeA7eyPNDEVkbjlFAqb+YN3704dN2
         QgS2KzFJn9Nm5QmuumFHmKIzn9vld1jHsJu0NRTKd9IObgBiQqzO2/AZYFcRVD2leJPX
         m/cCglGgDlnVRV0x5WWxCzQS4g1mjGG7EtdnDELMGkbypgcOdpXBCS33V9plXLJELRHn
         W0Ow==
In-Reply-To: <5283B76B.8070902-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd Mailing List <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

2013/11/13 Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>:
> What about if you generate it with the keyboard plugged in? It should
> include the usbhid module then, but does it actually work?

Will try a bit later, but I suspect this is the wrong direction of thought.

> The problem we're encountering is that even with the usbhid module
> included in the host-only initrd, it still doesn't work - even after
> manually modprobing it from a ps/2 keyboard.

All modules that are needed for the user's keyboard are included in the initrd.

> As I don't have the h/w I cannot tell what component is missing to make
> it all work. I'm currently suspecting some kind of usb host controller
> interface driver or something, but have yet to hear back from the user
> so any insights or info you have would be appreciated.

I'd suspect something related to USB power saving. This is the most
frequent reason for USB keyboards and mice to misbehave - the host
just turns them off mistakenly. So
/lib/udev/rules.d/42-usb-hid-pm.rules does look relevant.

-- 
Alexander E. Patrakov
