From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: New rd.* namespace for dracut-008
Date: Fri, 29 Oct 2010 10:17:57 +0200
Message-ID: <4CCA8335.1090003@redhat.com>
References: <4CC99414.5060607@redhat.com> <20101028174147.GB2367@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101028174147.GB2367-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/28/2010 07:41 PM, Bill Nottingham wrote:
> Harald Hoyer (harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said:
>>         rdudevdebug
>>             rd.udev.debug
>>
>>         rdudevinfo
>>             rd.udev.info
>
> Any chance that these could be made generic options that udev itself
> honors?
>
> Bill
>

See udevd(8), there is already:

KERNEL COMMAND LINE
        udev.log-priority=
            Set the logging priority.

        udev.children-max=
            Limit the number of parallel executed events.

        udev.exec-delay=
            Number of seconds to delay the execution of RUN instructions. This 
might be useful when
            debugging system crashes during coldplug cause by loading 
non-working kernel modules.
