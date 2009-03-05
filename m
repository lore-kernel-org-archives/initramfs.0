From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Thu, 05 Mar 2009 08:23:54 +0100
Message-ID: <49AF7E0A.8040107@redhat.com>
References: <49AE99D2.1000501@bfh.ch> <0227279C-8C23-4501-B163-04470D0C0F35@gmail.com> <49AEAF16.6010008@bfh.ch> <14BAD8D9-B114-4979-B9CE-BA20CEEF768D@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <14BAD8D9-B114-4979-B9CE-BA20CEEF768D-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Victor Lowther wrote:
> On Mar 4, 2009, at 10:40 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org> 
> wrote:
> 
>> Victor Lowther wrote:
>> [snip]
>>>> Second I have to ask how far Dracut needs (and wants) to go with the 
>>>> "One initrd to rule them all". The different distros will need to 
>>>> customize the initrd anyway. Think in terms of splash-screens, 
>>>> different versions of utilities and configs or just plain 'crazy and 
>>>> convoluted'...
>>> I would have the goal of making dracut be able to generate a working 
>>> no-frills initramfs with minimal (preferably no) distro 
>>> customization, and have a hook structure that allows the distros to 
>>> customize the initrams without having to patch things.
>>
>> Yes, that's why I suggested Fallbacks (or maybe we should call them 
>> "sane defaults").
>> I see a few problems with the modules/hook structure though: If, for 
>> example, we provide a generic find-modules and the distro wants 
>> completely other functionality, that part of Dracut would have to be 
>> changed/disabled. That's a "patch" for me.
> 
> Hmmm... I am not seeing the difficulty here. Perhaps a code snippet or a 
> more detailed use case would help.

Well, you could specify which modules to use in dracut.conf. Just add your 
modules and leave out the modules you don't want. No "patch" involved.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
