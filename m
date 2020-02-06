From: Niels Thykier <niels-g5vtf2JUtkjR7s880joybQ@public.gmane.org>
Subject: Re: Producing verifiable initramfs images
Date: Thu, 6 Feb 2020 08:31:07 +0100
Message-ID: <4ceef357-7b59-e4ed-52c2-1843013c8439@thykier.net>
References: <CACdnJutwsCPERLR=tF65O=2tCgf+BHbWmsC6bpVrhwyOXcKCxA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thykier.net; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:subject:from:references:cc:to:from;
        bh=l/RKPr7gAGg5BLmCLVnJeuexLScEm/T2oIZOSqSVLo0=;
        b=Sf2QiKbEWjVV8g3qk8RUHWXY1MQ0s76H4qSXtcfIu626VlpkVOvMUl5NklHEUa07d3zTarRzgEpju
         qhx7ant5tVdAjgaBczFmNDDqqAtL8ePSCEjWp338u4Dd/u8IwpYDDoVoSIpKyzggy5FThtZAOJWA2Z
         +aVMPVklUzLQUyxJOZYmLLez92aaB7FjvLkUCkshiH2fTwPgnNRp3AOCxne2xOugD8STnSaWu/u+AM
         a3ceFsRn67WQeBD4KhkI7cs4IcV64JkTc8QeurqBRYmMwMnvRfLoMjaMOOcqKQbfP4CvzLIidO/xiJ
         /uKMZ9x5IR3fKfMm5emB+G5tUktFv4w==
In-Reply-To: <CACdnJutwsCPERLR=tF65O=2tCgf+BHbWmsC6bpVrhwyOXcKCxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Matthew Garrett <mjg59-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Matthew Garrett:
> [...]
> 
> The second is a different problem, but still seems achievable. Each
> package that potentially adds content to the initramfs could provide a
> pre-build CPIO containing its code, and based on local configuration
> we can ask grub to load those as well.
> 
> This would result in something that's roughly equivalent to our
> current situation, but would allow us to verify that the initramfs
> images containing code hadn't been tampered with. [...]
> 
> A minimal proof of concept here would presumably be a patch to the
> kernel package to build an initramfs binary package, and then some
> additional tooling to copy appropriate config to the boot partition
> and have grub pick that up. Does anybody have any strong feelings on
> the topic? If not, I'll try to mock this up.
> 

Hi Matthew,

Thanks for working on making initramfs verifiable. :)

Let me know if/when there are any changes need to dh_installinitramfs
and I will happy to review them.  At the moment, it is just an easy way
to inject "update-initramfs -u" in the relevant maintscripts if the
package has a /usr/share/initramfs-tools/hooks.

If we can solve this without using maintscripts, I would be even happier
and am ready to do my part in that if you need any help there!  I know
it is not the main goal of what you are trying to here and nor should it
be a blocker for it - this is just me hoping for the best! :)

~Niels
