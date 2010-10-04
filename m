From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: NFS root with Dracut not calling nfsroot script
Date: Mon, 4 Oct 2010 13:35:35 +0200
Message-ID: <4CA9BC07.3090008@bfh.ch>
References: <20101002062617.5730102kmedzh6uo@webmail.zoltak.com> <20101004152252.15833xc2gkzz1mdc@webmail.zoltak.com> <4CA9998F.7060701@redhat.com> <20101004222036.53485185m6mhh11c@webmail.zoltak.com> <20101004222420.11791ue5kephey5c@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101004222420.11791ue5kephey5c-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org" <daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/04/2010 01:24 PM, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org wrote:
> Quoting daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org:
>> I've attached a new init.log.
> 
> Correct init.log attached!

Ahh.. thanks!

[quote]
ifup.eth0.778 + dhclient -4 -1 -q -cf /etc/dhclient.conf -pf /tmp/dhclient.eth0.pid -lf /tmp/dhclient.eth0.lease eth0
RTNETLINK answers: File exists
[/quote]

This is strange.

Would you mind trying with the older dhclient and removing the '-4' option? Might help seeing where/what the problem is.

Thanks,
Philippe
 
