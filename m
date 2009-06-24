From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Old style <server-ip>:/<path> not handled
Date: Wed, 24 Jun 2009 08:51:26 +0200
Message-ID: <4A41CCEE.9050705@bfh.ch>
References: <4A410FA7.8000509@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A410FA7.8000509-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
>> # This script is sourced, so root should be set. But let's be paranoid
>> [ -z "$root" ] && root=$(getarg root=)
>> [ -z "$netroot" ] && netroot=$(getarg netroot=)
>> [ -z "$nfsroot" ] && nfsroot=$(getarg nfsroot=)
>>
>> # Handle old style <server-ip>:/<path
>> case "$netroot" in
>>     [0-9]*:/*|[0-9]*\.[0-9]*\.[0-9]*[!:]|/*)
>>        netroot=nfs:$netroot;;
>> esac
> 
> By the current code it seems the old style root=<server-ip>:/<path> is 
> not actually handled.

The current code only handles netroot=<oldstyle>. This works for cmdline 
or if <oldstyle> is delivered by dhcp root-path. I think that was 
haralds intention anyway.

> I'm soon pushing a patch that restricts NFS to only root= which should 
> fix this and eliminate the redundant root= and netroot= test cases.
> 
> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
