From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Fri, 19 Jun 2009 11:06:32 -0400
Message-ID: <20090619150632.GA7645@nostromo.devel.redhat.com>
References: <4A3B968C.5070600@bfh.ch> <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A3BA5EA.3020202-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
>> Depending on your switch configuration, the time for the switch to start
>> passing traffic again on link bounce couuld be anywhere from 0.1 seconds
>> to 20 seconds...
>
> Quite correct. Up until now I've fared well with adding 1-5 second  
> sleeps to my stuff. But yes it could even take longer. Any ideas how to  
> solve this better?

Post-boot, we (in Fedora) we check every half second until a configurable
delay period (defualt: five seconds) has elapsed; if we don't have a link
by then, we punt. Of course, you probably don't want configuration
parameters in the initramfs.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
