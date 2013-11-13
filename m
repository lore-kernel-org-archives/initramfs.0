From: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Wed, 13 Nov 2013 22:49:21 +0600
Message-ID: <CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
	<52830E31.30107@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Q/aTtgu9DJotOBu5TVsw5RDntqgYJdPgJ0o9WN5mVM4=;
        b=wZEKJpEfSUploEIA9Pd3ADkJIw08D/5m2HXn0mRRhBz6QeNcw6+YVUqkq+t6bk75Hj
         HqiGtsUqEmsI68aQP3GsXwTHTLusv6Jcc8PhQ0XjrMVF/CsSPKifYi/R3DoNqovaWDyT
         ng5ypy5ue2PcYisgng0mYzjrvue3xzK5Ey3NlX6QC1DJT8Mf92zAMJh9fa9R7XWfrPnj
         Rjla+MeR25ga7qKqrLkV+12Rh/QgRKby4FRQmywOQSbAzETn9NF6bwriLuLvxu/S8bAN
         +15x59QpxUvTsdnh8abL+bxpH+IZ5r39aLwOuC8Rlh2Ic5c2bzQKOqfHImhrhjEJv5Sq
         9Qrg==
In-Reply-To: <52830E31.30107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd Mailing List <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

2013/11/13 Alexander E. Patrakov <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Colin Guthrie wrote:
>>
>> Hi,
>>
>> In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
>> unable to enter their encrypted root password via a wireless keyboard
>> connected with a Logitech, Inc. Unifying Receiver.
>
>
> Just in case, I do have the same model of wireless keyboard and will
> validate the bug (for the LUKS-password case) later today on my laptop.
>
> The keyboard does work on my desktop, but there's no initramfs there.

I hereby confirm that the wireless Logitech keyboard works for
entering the LUKS password on the laptop, if one does not create a
host-only initramfs. This is with dracut-031.

Some relevant kernel config bits:

CONFIG_HID=y
CONFIG_HID_GENERIC=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m   # dracut is smart enough to include it,
even though the password entry works well without it

CONFIG_USB_HID=m

CONFIG_USB_XHCI_HCD=m
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_PCI=m

-- 
Alexander E. Patrakov
