From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Wed, 4 Mar 2009 11:28:54 -0600
Message-ID: <14BAD8D9-B114-4979-B9CE-BA20CEEF768D@gmail.com>
References: <49AE99D2.1000501@bfh.ch> <0227279C-8C23-4501-B163-04470D0C0F35@gmail.com> <49AEAF16.6010008@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=jpp0/D/8FEzjEspSlMgdhFpvxRirQ/ufWR+OwJyzqVM=;
        b=vWEkLvf1hPwlNUAIP2/mE8S7AscvGQzdUpixFfn/7HoTbap6wGj9fES+fvSYnyDsf8
         fhl3vXZj0YrLS2y6gmvQzc6gvsSgPUUEy9Vb6gVd3CiHRT1lPXRSKiayat8tJBkNcrHv
         hdxGgvZF/kHf9Wx9kCNA0QcDb7ji7ns8j33b4=
In-Reply-To: <49AEAF16.6010008-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar 4, 2009, at 10:40 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

> Victor Lowther wrote:
> [snip]
>>> Second I have to ask how far Dracut needs (and wants) to go with  
>>> the "One initrd to rule them all". The different distros will need  
>>> to customize the initrd anyway. Think in terms of splash-screens,  
>>> different versions of utilities and configs or just plain 'crazy  
>>> and convoluted'...
>> I would have the goal of making dracut be able to generate a  
>> working no-frills initramfs with minimal (preferably no) distro  
>> customization, and have a hook structure that allows the distros to  
>> customize the initrams without having to patch things.
>
> Yes, that's why I suggested Fallbacks (or maybe we should call them  
> "sane defaults").
> I see a few problems with the modules/hook structure though: If, for  
> example, we provide a generic find-modules and the distro wants  
> completely other functionality, that part of Dracut would have to be  
> changed/disabled. That's a "patch" for me.

Hmmm... I am not seeing the difficulty here. Perhaps a code snippet or  
a more detailed use case would help.

>
>
> [snip]
>>> I'm thinking of a debootstrappish system of suite/target (or topic/ 
>>> flavour) where Dracut specifically delegates those tasks away it  
>>> cannot solve on its own. We might even provide some simple things  
>>> like just including all drivers for testing purposes or as a  
>>> fallback solution.
>> Let's see how the current modules/hooks mechanism works for now. We  
>> can extend or scrap it if it turns out to not suit our needs.
>
> I was thinking a bit along the line of what should be included on a  
> netboot initrd. Personally I wouldn't want to see hooks for  
> cryptsetup or lvm in it. Hence the idea of suite/target to select  
> maybe a distro (could be 'dracut' for generic) and different targets  
> (might be netboot or a combination of block,crypt,lvm).

That can be handled by having an /etc/dracut.conf that contains a  
dracutmodules="my modules here" line. The default is "all", which  
loads all the modules on initramfs creation. Extending that  
functionality should not be a problem to define some defaults other  
than including everything.

>
> But well... I guess I'm violating list rules again. Patches speak  
> more than words, I'll see what I can cook up.

I look forward to them. :)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
