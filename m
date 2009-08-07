From: Alan Jenkins <sourcejedi.lkml-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: initramfs-tools stable release 0.93.3
Date: Fri, 7 Aug 2009 15:00:42 +0100
Message-ID: <9b2b86520908070700l318d24c0me34772daa4e65de0@mail.gmail.com>
References: <20090610153017.GA19401@stro.at> <1244716927.4532.34.camel@quest>
	 <20090725092159.GJ11967@stro.at> <1248871471.23840.50.camel@quest>
	 <4A7BD9B4.1090109@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HTmzdgxKnxQDA+do5H9IPEWL2tgArIGYxzE6RDP+SNw=;
        b=bI8GvX2YPr8qjUKfvcTqE8WRS7+AyJ4N5MDWUf2O6CR5Z2RKD2MsJH25fuUgjUsP+d
         76HtpKMvHVAHVCGScgXRcNyMkCh7AqrfCzDHx1OxcFPaTFNyQdvHI562ZW3iEamHRri6
         mdMOqctHj9bAqDfcJDI35zCELVcE3+xHt9jb4=
In-Reply-To: <4A7BD9B4.1090109-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Scott James Remnant <scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>, maximilian attems <max-U9r9yeDMy7A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org

On 8/7/09, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org> wrote:
> Scott James Remnant wrote:
> [snip]
>>>> Slimming the initramfs right down to the essentials reduces the boot
>>>> time by over a second!  Paradoxically, this means that the driver can be
>>>> loaded in the real system at roughly the same time point as it would be
>>>> loaded in a bloated initramfs.
>>> well afair the intel fast boot doesn't use initramfs in the fast path
>>> at all
>>>
>> Our fast boot does use an initramfs.
>
> This is a bit offtopic: Do you have any more info about intel fast boot?
> I use an intel atom board at home which supposedly has intel fast boot,
> but I haven't found any info on how to make use of that.
>
> Thanks,
> Philippe

Linux "fast boot" is purely a software feature.  The most significant
hardware feature is a BIOS which doesn't take too long before it loads
the kernel.

Possibly the marketing people have confused you with their use of the
word "supports".  The closest match to "supports intel fast boot"
would be "supported by Moblin".  Moblin is the optimized distribution
initially developed by Intel.  One of the optimizations was to limit
the supported hardware configurations.  Intel Atom boards were
obviously favoured ;-).  Cynicism aside, it's well worth a look.

Alan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
