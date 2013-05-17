From: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Fri, 17 May 2013 11:38:19 +1000 (EST)
Message-ID: <alpine.LFD.2.03.1305171058310.30473@beren.home>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info> <kn24ml$2s6$1@ger.gmane.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <kn24ml$2s6$1@ger.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 16 May 2013, Colin Guthrie wrote:
> Yeah it's almost certainly only for resume from suspend. Sadly this is
> controlled by the resume= kernel command line and when the initrd is
> generated it doesn't really know if it'll be needed or not.

I think Dracut could use the the "swap" flag in crypttab to determine that 
a volume is definitely not needed on boot, since this tells 
systemd-cryptsetup that the swap needs to be recreated on boot. And since 
this is a "plain" dm-crypt encrypted device, the (randomly generated) 
encryption key isn't dropped from the kernel on hibernation -- so, I don't 
think the initrd needs to touch it upon resuming from hibernation either.

(Ensuring the hibernation image itself isn't on the encrypted swap is a 
different problem altogether, of course. I haven't looked into how this 
might be done yet.)

> It would be interesting to get the /etc/fstab and /etc/cmdline.d/* files
> from the initrd itself. Possibly the hooks folder too. That way we can
> see exactly what it's waiting for. Assuming there is nothing sensitive
> on it, perhaps you can just upload the initrd somewhere?

No problem. Here are the "bad" and "good" initramfs's respectively:

http://michael.beta.anchortrove.com/bad-initramfs-3.9.1-301.fc19.x86_64.img
http://michael.beta.anchortrove.com/good-initramfs-3.9.1-301.fc19.x86_64.img

Regards,
Michael
