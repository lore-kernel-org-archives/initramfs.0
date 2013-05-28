From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Tue, 28 May 2013 13:43:24 +0200
Message-ID: <51A4985C.2090501@redhat.com>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info> <kn24ml$2s6$1@ger.gmane.org> <alpine.LFD.2.03.1305171058310.30473@beren.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.03.1305171058310.30473-N07bVqg5a7VBDLzU/O5InQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Cc: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/17/2013 03:38 AM, Michael Chapman wrote:
> On Thu, 16 May 2013, Colin Guthrie wrote:
>> Yeah it's almost certainly only for resume from suspend. Sadly this is
>> controlled by the resume= kernel command line and when the initrd is
>> generated it doesn't really know if it'll be needed or not.
> 
> I think Dracut could use the the "swap" flag in crypttab to determine that a
> volume is definitely not needed on boot, since this tells systemd-cryptsetup
> that the swap needs to be recreated on boot. And since this is a "plain"
> dm-crypt encrypted device, the (randomly generated) encryption key isn't dropped
> from the kernel on hibernation -- so, I don't think the initrd needs to touch it
> upon resuming from hibernation either.

fixed with commit bcfbddefe13d179d553da77cf66ada5e6fd804c8

Thanks for reporting!
