From: Benjamin Kingston <list-ses8GfRmtAZWzAuRflr9/A@public.gmane.org>
Subject: Re: Ignore or blacklist a disk from being brought up on boot
Date: Sun, 25 Aug 2013 15:58:43 -0700
Message-ID: <CAHA1JWJdqmyoqjs7Cp=HzH9F11xBDqR8bxobi51nPtrPFPir3w@mail.gmail.com>
References: <CAHA1JWJisaRVsf2uARPxCN14Fhgu05H9_TxU1zDbyu_3PSbYWA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexusnebula.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=ouvMfGY1LjCQMjAJOAGny6zCF/KLhhDbRvBaW7hmWl0=;
        b=C8pqhIYAEMjpN9J6xqyEVw24Ieka1lDNL+MzrgU3Zw2RRYgQGlDB/QVsI3Wz8Fe8ND
         dKFM9GQrjFs/Mir6O3sJTa8Oy5T1gLbwZB2H6JJIMExveJOn6MXxZZbAfGKa9xflnKHp
         FGADJQjtqpD2QBpfFUSTIXMC1FOpqA70JMcx0=
In-Reply-To: <CAHA1JWJisaRVsf2uARPxCN14Fhgu05H9_TxU1zDbyu_3PSbYWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I have my boot partition on a pin protected flash drive and have
embedded the encryption keyfile for my filesystem in my initramfs
image to automate unlocking my computer with just the flash pin. The
issue with this comes when generating the initramfs through dracut,
because the boot disk is mounted and listed in /proc/self/mountinfo
and gets a systemd entry that requires it to be brought online.

Since the keyfile is embedded in the image in ram the boot disk is not
needed to be brought online, but since the USB is reset, this requires
me to enter the pin on the flash drive a second time, just to unlock
the volume to satisfy systemd.

is there a way to ignore a particular device when running dracut, or
at least change its timeout and systemd status to not be boot
effecting?
