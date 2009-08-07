From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: initramfs-tools stable release 0.93.3
Date: Fri, 7 Aug 2009 09:37:24 +0200
Message-ID: <4A7BD9B4.1090109@bfh.ch>
References: <20090610153017.GA19401@stro.at> <1244716927.4532.34.camel@quest>  <20090725092159.GJ11967@stro.at> <1248871471.23840.50.camel@quest>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1248871471.23840.50.camel@quest>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Scott James Remnant <scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Cc: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org

Scott James Remnant wrote:
[snip]
>>> Slimming the initramfs right down to the essentials reduces the boot
>>> time by over a second!  Paradoxically, this means that the driver can be
>>> loaded in the real system at roughly the same time point as it would be
>>> loaded in a bloated initramfs.
>> well afair the intel fast boot doesn't use initramfs in the fast path
>> at all
>>
> Our fast boot does use an initramfs.

This is a bit offtopic: Do you have any more info about intel fast boot? 
I use an intel atom board at home which supposedly has intel fast boot, 
but I haven't found any info on how to make use of that.

Thanks,
Philippe

> 
> Scott
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
