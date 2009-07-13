From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 09/10] initqueue now loops until /dev/root exists or root
 is mounted
Date: Mon, 13 Jul 2009 11:53:05 +0200
Message-ID: <4A5B0401.7050404@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-10-git-send-email-harald@redhat.com> <4A51BBE0.6030603@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A51BBE0.6030603-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/06/2009 10:54 AM, Seewer Philippe wrote:
> Suggestion: If this description goes into a README or something similar,
> I'd rewrite this as "...network filesystems like NFS that do not use
> devicefiles are an exception,..."

ok, will do

>
> Please do not use 'udevadm settle timeout=0'. Older version of udev,
> especially the one on debian lenny does not support a value of 0.
>
> I suggest to increase that timeout to 1.
>

ok, will do

> Question: Would it make sense to reset i to 0 after we've opened a
> shell? Or is it the intention that if a shell is opened and closed that
> we drop in again as soon as possible?

Well, if the user had a shell, he had the chance to find the real root, so I 
don't think 20 more loops will solve the problem.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
