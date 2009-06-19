From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Fri, 19 Jun 2009 11:08:57 -0500
Message-ID: <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
References: <4A3B968C.5070600@bfh.ch> <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=7xFMvfetjQZ6lsoZ4pKBx7giJafwrPRqV+BV8wjO4sw=;
        b=Xp/BiVJAbSvS4PTPAh9O2H/UpHAaRG3j9DSAgalpDO6dG9h8YDD+zWw0iTXE3o8R8i
         /qTR5QF1DK0O6ogFYi0dUn/0cwi/IyvQLPDtuQm7r7+IqMQpOojlt24qitRJ9FQKxUwt
         sCOqBcXj5KtT9g0B3OqeOimu30cUH/cdFkUTE=
In-Reply-To: <4A3BA5EA.3020202-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 19, 2009, at 9:51 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

>
>
> Bill Nottingham wrote:
>> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said:
>>> While testing in our production environment, I discovered
>>> that the time between interface configuration and trying to mount  
>>> the nfs root is too short if the dhcp-server provides an mtu.  
>>> Having to set a mtu means that netroot
>>> executes 'ip link down', set's the mtu and the does
>>> 'ip link up' again.
>>>
>>> This results in the mount error "No route to host", because
>>> the network equipment has not had enough time to "shake hands".  
>>> The patch below adds a sleep 1 after interface configuration, to  
>>> give the equipment enough time.
>> Depending on your switch configuration, the time for the switch to  
>> start
>> passing traffic again on link bounce couuld be anywhere from 0.1  
>> seconds
>> to 20 seconds...
>
> Quite correct. Up until now I've fared well with adding 1-5 second  
> sleeps to my stuff. But yes it could even take longer. Any ideas how  
> to solve this better?
>

Disable spanning tree on all edge switch ports. :)

Or you can include ethtool and check every half second until a timeout  
to see if the link is back.


> Regards,
> Philippe
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
