From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Wed, 4 Mar 2009 10:05:43 -0600
Message-ID: <0227279C-8C23-4501-B163-04470D0C0F35@gmail.com>
References: <49AE99D2.1000501@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=T4Ah6D0/HpkjthGzT5kACVrRb4ky04DeNuWF3rRXKt0=;
        b=kXdyD74L9r+KGmCmUR1pXFD4j13qjo0Z59tNvQwkrf/8ghlz95P0ssTJFj3shroX2f
         XMSp8dsIlxyG5O4+3Vczgsq1Kbb0KkQS+Xl2YzPxPGZ8aPc80WlgtKdBwZAQWqsPT3RZ
         m53u1GM1MMlOvDlO82R21lLdYKcerYv4e4K10=
In-Reply-To: <49AE99D2.1000501-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar 4, 2009, at 9:10 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

> Hello all
>
> ...I'm starting a new subject on this for the sake of my brain.  
> Mixing patches and important discussions always gets me heavily  
> confused...
>
>
> First of all, please remember that Debian has a certain policy and  
> even though we should make Dracut work on Debian, Debian itself  
> certainly won't adopt Dracut until at least the next full release.  
> Which we all know will be released when its ready.
>
>
> Second I have to ask how far Dracut needs (and wants) to go with the  
> "One initrd to rule them all". The different distros will need to  
> customize the initrd anyway. Think in terms of splash-screens,  
> different versions of utilities and configs or just plain 'crazy and  
> convoluted'...

I would have the goal of making dracut be able to generate a working  
no-frills initramfs with minimal (preferably no) distro customization,  
and have a hook structure that allows the distros to customize the  
initrams without having to patch things.

>
> So why not just go the way of 'as generic as possible', provide the  
> common denominator and let the Distros sort out the rest?

That is my goal, at least.

>
> An example: As Kay pointed out, we can never know if the provided  
> rules really are the right ones. Getting to root might work but what  
> about after that? Some stored information in /dev/.udev might be  
> horribly incompatible. Best leave it to the Distro or local  
> maintainer to tell Dracut which udev parts are the "good" ones.

Based on what Kay has said, it seems like Debian is the odd man out  
here - other distros just use the upstream udev rules to the extent  
feasible.

>
> Another example: As seen, we need to load a keymap for say,  
> cryptroot. But which keymap? And where is it stored? Leave that to  
> the Distro if it wants to load one.

Yep.

>
> And another example: Yes, Debian and Ubuntu don't provide modules. 
> {block,net,...} Can we really find a way of finding all block drivers?

Nope. I have a workaround that will work as long as the directory  
structure under /lib/modules/ stays reasonable, but there is no  
reasonable way to enforce that it will always work.

> Certainly stupid me can't think of a way to be sure we "really  
> really" have all block drivers without including every single .ko.  
> Leave it to the user to specifically set drivers or the Distro to  
> tell Dracut which drivers to include.

Indeed.

> I'm thinking of a debootstrappish system of suite/target (or topic/ 
> flavour) where Dracut specifically delegates those tasks away it  
> cannot solve on its own. We might even provide some simple things  
> like just including all drivers for testing purposes or as a  
> fallback solution.

Let's see how the current modules/hooks mechanism works for now. We  
can extend or scrap it if it turns out to not suit our needs.

>
> Regards,
> Philippe
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
