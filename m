From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute paths for utilities
Date: Thu, 2 Jul 2009 16:40:54 +0200
Message-ID: <4A4CC6F6.2070907@bfh.ch>
References: <4A4CBE3B.10703@bfh.ch> <1246545040.28989.7.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246545040.28989.7.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



David Dillow wrote:
> On Thu, 2009-07-02 at 16:03 +0200, Seewer Philippe wrote:
>> diff --git a/dracut b/dracut
> 
> It would be good if your commit message mentioned why it is not a good
> idea to use absolute paths, eg different distros put things in different
> places, etc.

We've had the discussion about absolute paths and distros a few times, 
so it should be obvious.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
