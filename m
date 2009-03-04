From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Wed, 4 Mar 2009 17:40:54 +0100
Message-ID: <49AEAF16.6010008@bfh.ch>
References: <49AE99D2.1000501@bfh.ch> <0227279C-8C23-4501-B163-04470D0C0F35@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0227279C-8C23-4501-B163-04470D0C0F35-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Victor Lowther wrote:
[snip]
>> Second I have to ask how far Dracut needs (and wants) to go with the 
>> "One initrd to rule them all". The different distros will need to 
>> customize the initrd anyway. Think in terms of splash-screens, 
>> different versions of utilities and configs or just plain 'crazy and 
>> convoluted'...
> 
> I would have the goal of making dracut be able to generate a working 
> no-frills initramfs with minimal (preferably no) distro customization, 
> and have a hook structure that allows the distros to customize the 
> initrams without having to patch things.

Yes, that's why I suggested Fallbacks (or maybe we should call them 
"sane defaults").
I see a few problems with the modules/hook structure though: If, for 
example, we provide a generic find-modules and the distro wants 
completely other functionality, that part of Dracut would have to be 
changed/disabled. That's a "patch" for me.


[snip]
>> I'm thinking of a debootstrappish system of suite/target (or 
>> topic/flavour) where Dracut specifically delegates those tasks away it 
>> cannot solve on its own. We might even provide some simple things like 
>> just including all drivers for testing purposes or as a fallback 
>> solution.
> 
> Let's see how the current modules/hooks mechanism works for now. We can 
> extend or scrap it if it turns out to not suit our needs.

I was thinking a bit along the line of what should be included on a 
netboot initrd. Personally I wouldn't want to see hooks for cryptsetup 
or lvm in it. Hence the idea of suite/target to select maybe a distro 
(could be 'dracut' for generic) and different targets (might be netboot 
or a combination of block,crypt,lvm).

But well... I guess I'm violating list rules again. Patches speak more 
than words, I'll see what I can cook up.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
