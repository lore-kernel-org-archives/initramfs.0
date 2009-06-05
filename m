From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Use dhclient.conf instead of -R
Date: Fri, 05 Jun 2009 15:02:45 -0400
Message-ID: <4A296BD5.902@redhat.com>
References: <4A293933.80601@bfh.ch> <20090605160253.GJ5107@nostromo.devel.redhat.com> <4A29603D.1090202@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A29603D.1090202-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 02:13 PM, Seewer Philippe wrote:
>> We have a /etc on the initramfs ... conf files should go there.
>
> right, I tend to forget that it seems. Thanks for pointing it out. Fixed
> patch below

OK, this seems to be working with dhclient-4.1.0-20 in Fedora 11.

I suppose go ahead and push.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
